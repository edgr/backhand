class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :sent_reviews, class_name: 'UserReview'
  has_many :received_reviews, class_name: 'UserReview'
end
