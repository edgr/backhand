class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :sent_reviews, class_name: 'UserReview'
  has_many :received_reviews, class_name: 'UserReview'

  has_many :sent_challenges, class_name: 'Challenge'
  has_many :received_challenges, class_name: 'Challenge'

  has_many :tags, through: :user_tags

  validates :first_name, :last_name, :level, :address, presence: true
  validates :phone_number, presence: true,
                           numericality: true,
                           length: { minimum: 10, maximum: 15 }
  mount_uploader :picture, PictureUploader
end
