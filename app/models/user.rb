class User < ApplicationRecord
  after_create :set_skills
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :sent_reviews, class_name: 'UserReview'
  has_many :received_reviews, class_name: 'UserReview'

  has_many :sent_challenges, class_name: 'Challenge', foreign_key: :challenger_id
  has_many :received_challenges, class_name: 'Challenge', foreign_key: :challengee_id

  has_many :tags, through: :user_tags

  has_one :computed_skills_set, dependent: :destroy

  validates :first_name, :last_name, :level, :address, presence: true
  validates :phone_number, presence: true,
                           numericality: true,
                           length: { minimum: 10, maximum: 15 }
  
  mount_uploader :picture, PictureUploader

  def all_challenges
    self.sent_challenges.played + self.received_challenges.played
  end

  def challenges_won
    Challenge.where(winner: self.id.to_s)
  end

  def challenges_lost
    Challenge.where(loser: self.id.to_s)

  private

  def set_skills
    self.computed_skills_set = ComputedSkillsSet.new
  end
end
