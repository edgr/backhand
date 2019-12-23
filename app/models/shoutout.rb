class Shoutout < ApplicationRecord
  belongs_to :user
  validates :message, presence: true,
                      length: { maximum: 80 }
  validates :recipients, presence: true
  validates :minimum_level, presence: true
  validates :maximum_level, presence: true
end
