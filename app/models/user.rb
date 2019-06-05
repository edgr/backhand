class User < ApplicationRecord
  after_create :set_skills

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode, if: :will_save_change_to_address?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :sent_reviews, class_name: 'UserReview', foreign_key: :sender_id, dependent: :destroy
  has_many :received_reviews, class_name: 'UserReview', foreign_key: :receiver_id, dependent: :destroy

  has_many :sent_challenges, class_name: 'Challenge', foreign_key: :challenger_id, dependent: :destroy
  has_many :received_challenges, class_name: 'Challenge', foreign_key: :challengee_id, dependent: :destroy

  has_many :tags, through: :user_tags

  has_one :computed_skills_set, dependent: :destroy

  validates :first_name, :last_name, :level, :address, presence: true, on: :update
  validates :phone_number, presence: true,
                           numericality: true,
                           length: { minimum: 10, maximum: 15 },
                           on: :update

  mount_uploader :picture, PictureUploader

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
    "#{first_name} #{last_name}"
  end

  def age
    ((Date.today - self.birthday).to_i) / 365
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
