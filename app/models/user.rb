class User < ApplicationRecord
  after_create :set_skills

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode, if: :will_save_change_to_address?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :secure_validatable, email_validation: false

  mount_uploader :picture, PictureUploader

  has_many :sent_reviews, class_name: 'UserReview', foreign_key: :sender_id, dependent: :destroy
  has_many :received_reviews, class_name: 'UserReview', foreign_key: :receiver_id, dependent: :destroy

  belongs_to :club, optional: true

  has_many :matches, foreign_key: :player_1_id, dependent: :destroy
  has_many :matches, foreign_key: :player_2_id, dependent: :destroy

  has_one :computed_skills_set, dependent: :destroy

  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: "only allows valid emails" }
  validates :phone_number, presence: true,
                           # uniqueness: true,
                           # numericality: true,
                           length: { minimum: 8, maximum: 15 }
  validates :first_name, :last_name, presence: true,
                                     length: { minimum: 2 },
                                     if: :active_or_step1?
  validates :address, presence: true,
                      if: :active_or_step1?
  validates :country, presence: true,
                      length: { maximum: 60 },
                      if: :active_or_step1?
  validates :place_of_birth, presence: true,
                             if: :active_or_step1?
  validates :birthday, presence: true,
                       if: :active_or_step1?
  validates :gender, presence: true,
                     inclusion: { in: %w(Male Female Other) },
                     if: :active_or_step1?
  validates :height, :weight, presence: true,
                              length: { in: 2..3 },
                              numericality: { only_integer: true },
                              if: :active_or_step1?
  validates :level, presence: true,
                    inclusion: { in: ["Beginner", "Beginner +", "Intermediate", "Intermediate +", "Advanced", "Advanced +", "Expert", "Expert +", "Semi-pro", "Semi-pro +", "Pro"] },
                    if: :active_or_step2?
  validates :style_of_play, presence: true,
                            inclusion: { in: %w(grinder baseliner attacker puncher server-volleyer) },
                            if: :active_or_step2?
  validates :handedness, presence: true,
                         inclusion: { in: %w(righty lefty) },
                         if: :active_or_step2?
  validates :backhand_style, presence: true,
                             inclusion: { in: ["one handed backhand", "two handed backhand"] },
                             if: :active_or_step2?
  validates :bio, presence: true,
                  length: { maximum: 500 },
                  if: :active_or_step3?
  # validates :picture, presence: true, if: :active_or_step3?

  scope :active, -> { where("status = 'active'") }

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
    # %w[Beginner 'Beginner +' Intermediate 'Intermediate +' Advanced 'Advanced +' Expert 'Expert +' Semi-pro 'Semi-pro +' Pro]
    ["Beginner", "Beginner +", "Intermediate", "Intermediate +", "Advanced", "Advanced +", "Expert", "Expert +", "Semi-pro", "Semi-pro +", "Pro"]
  end

  def self.genders
    %w[Male Female Other]
  end

  def self.handedness
    %w[Righty Lefty]
  end

  def self.backhand
    ['One Handed','Two Handed']
  end

  def self.styles
    %w[baseliner attacker grinder server-volleyer puncher]
  end

  def matches_won
    MatchResult.where("winner_id = ? AND confirmed = ?", self.id.to_s, true)
  end

  def matches_lost
    MatchResult.where("loser_id = ? AND confirmed = ?", self.id.to_s, true)
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def age
    (Date.today - self.birthday).to_i / 365
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
    against: [:address, :level, :first_name, :last_name, :style_of_play, :gender, :country, :handedness, :backhand_style, :club_id],
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

  private

  def set_skills
    self.computed_skills_set = ComputedSkillsSet.new
  end
end
