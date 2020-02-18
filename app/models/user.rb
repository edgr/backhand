class User < ApplicationRecord
  after_create :set_skills
  after_create :subscribe_to_newsletter

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode, if: :will_save_change_to_address?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :secure_validatable, email_validation: false

  mount_uploader :picture, PictureUploader

  has_many :sent_reviews, class_name: 'UserReview', foreign_key: :sender_id, dependent: :destroy
  has_many :received_reviews, class_name: 'UserReview', foreign_key: :receiver_id, dependent: :destroy

  belongs_to :club, optional: true

  has_many :matches, foreign_key: :player_1_id, dependent: :destroy
  has_many :matches, foreign_key: :player_2_id, dependent: :destroy

  has_one :computed_skills_set, dependent: :destroy

  has_many :favorites
  has_many :favorite_players, through: :favorites, source: :favorited, source_type: 'User'

  has_many :messages

  validates :email, presence: true, uniqueness: true
  validates :phone_number, length: { minimum: 8, maximum: 15 }
  validates :first_name, :last_name, length: { minimum: 2 }, if: :active_or_step1?
  validates :address, presence: true, if: :active_or_step1?
  validates :country, presence: true, length: { maximum: 60 }, if: :active_or_step1?
  validates :birthday, presence: true, if: :active_or_step1?
  validates :gender, inclusion: { in: %w[male female other] }, if: :active_or_step1?
  validates :height, :weight, length: { in: 2..3 }, numericality: { only_integer: true }, if: :active_or_step1?, allow_blank: true
  validates :level, presence: true,
                    inclusion: { in: %w[beginner beginner_plus intermediate intermediate_plus advanced advanced_plus expert expert_plus semi_pro semi_pro_plus pro] },
                    if: :active_or_step2?
  validates :style_of_play, presence: true, inclusion: { in: %w[grinder baseliner attacker puncher server_volleyer] }, if: :active_or_step2?
  validates :handedness, presence: true, inclusion: { in: %w[righty lefty] }, if: :active_or_step2?
  validates :backhand_style, presence: true, inclusion: { in: %w[one_handed_backhand two_handed_backhand] }, if: :active_or_step2?
  validates :bio, presence: true, length: { maximum: 500 }, if: :active_or_step3?
  # validates :picture, presence: true, if: :active_or_step3?

  scope :active, -> { where("status = 'active'") }
  scope :ordered_by_points, -> { order(points: :desc) }

  typed_store :settings do |s|
    s.boolean :new_callout_email, default: true, null: false
    s.boolean :new_player_review_email, default: true, null: false
    s.boolean :new_match_result_email, default: true, null: false
    s.boolean :new_game_event_email, default: true, null: false
    s.boolean :confirmed_match_result_email, default: true, null: false
    s.boolean :show_my_whatsapp, default: true, null: false
    s.string :language, default: 'en'
  end

  def active?
    status == 'active'
  end

  def active_or_step1?
    status.include?('step1') || active?
  end

  def active_or_step2?
    status.include?('step2') || active?
  end

  def active_or_step3?
    status.include?('step3') || active?
  end

  def opponents
    User.active.where.not(id: self.id)
  end

  def partners
    User.active.where.not(id: self.id)
  end

  def self.levels
    %i[beginner beginner_plus intermediate intermediate_plus advanced advanced_plus expert expert_plus semi_pro semi_pro_plus pro]
  end

  def self.genders
    %i[male female other]
  end

  def self.handedness
    %i[righty lefty]
  end

  def self.backhand_style
    %i[one_handed_backhand two_handed_backhand]
  end

  def self.style_of_play
    %i[baseliner attacker grinder server_volleyer puncher]
  end

  def matches_won
    MatchResult.where("winner_id = ? AND confirmed = ?", self.id.to_s, true)
  end

  def matches_lost
    MatchResult.where("loser_id = ? AND confirmed = ?", self.id.to_s, true)
  end

  def full_name
    (first_name && last_name) ? "#{first_name.capitalize} #{last_name.capitalize}" : email
  end

  def age
    (Date.today - self.birthday).to_i / 365 if self.birthday
  end

  def notify
    notification = 0
    if self.matches.any?
      self.matches.each { |match|
        if match.player_2 == self
          notification += 1 if match.match_result.confirmed == false
        end
      }
    end
    return notification
  end

  include PgSearch
  pg_search_scope :search_user_fields,
                  against: %i[address level first_name last_name style_of_play gender country handedness backhand_style],
                  using: {
                    tsearch: { prefix: true }
                  }

  def all_matches
    Match.where("matches.player_1_id = ? OR matches.player_2_id = ?", self, self)
  end

  def all_events
    Event.upcoming.where("events.player_1_id = ? OR events.player_2_id = ? OR events.player_3_id = ? OR events.player_4_id = ?", self, self, self, self)
  end

  def pending_matches
    all_matches.joins(:match_result).where("match_results.confirmed = false")
  end

  def soft_delete
    update_attribute(:deleted_at, Time.current)
  end

  def active_for_authentication?
    super && !deleted_at
  end

  def inactive_message
    !deleted_at ? super : :deleted_account
  end

  private

  def set_skills
    self.computed_skills_set = ComputedSkillsSet.new
  end

  def subscribe_to_newsletter
    SubscribeToNewsletterService.new(self).call if Rails.env.production?
  end
end
