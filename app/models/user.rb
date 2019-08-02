class User < ApplicationRecord
  after_create :set_skills

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode, if: :will_save_change_to_address?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :picture, PictureUploader

  has_many :sent_reviews, class_name: 'UserReview', foreign_key: :sender_id, dependent: :destroy
  has_many :received_reviews, class_name: 'UserReview', foreign_key: :receiver_id, dependent: :destroy

  # has_many :sent_challenges, class_name: 'Challenge', foreign_key: :challenger_id, dependent: :destroy
  # has_many :received_challenges, class_name: 'Challenge', foreign_key: :challengee_id, dependent: :destroy

  has_many :matches, foreign_key: :player_id, dependent: :destroy
  has_many :matches, foreign_key: :opponent_id, dependent: :destroy

  has_one :computed_skills_set, dependent: :destroy

  validates :phone_number, presence: true,
                           numericality: true,
                           length: { minimum: 8, maximum: 15 }

  validates :first_name, :last_name, :address, :country, :place_of_birth, :birthday, :gender, :height, :weight, presence: true, if: :active_or_step1?
  validates :level, :style_of_play, :handedness, :backhand_style, presence: true, if: :active_or_step2?
  # validates :picture, presence: true, if: :active_or_step3?
  validates :bio, presence: true, if: :active_or_step3?

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

  def self.levels
    %w[Beginner Intermediate Advanced Semi-pro Pro]
  end

  def self.genders
    %w[Male Female Other]
  end

  def self.styles
    %w[baseliner attacker grinder server-volleyer puncher]
  end

  def all_challenges
    self.sent_challenges.played + self.received_challenges.played
  end

  def challenges_won
    Challenge.where(winner: self.id.to_s)
  end

  def challenges_lost
    Challenge.where(loser: self.id.to_s)
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def age
    (Date.today - self.birthday).to_i / 365
  end

  include PgSearch
  pg_search_scope :search_user_fields,
    against: [:address, :level, :first_name, :last_name, :style_of_play, :gender, :country, :ranking, :handedness, :backhand_style, :review_score, :club_id],
    using: {
      tsearch: { prefix: true }
    }

  private

  def set_skills
    self.computed_skills_set = ComputedSkillsSet.new
  end
end
