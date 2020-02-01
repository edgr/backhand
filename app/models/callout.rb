class Callout < ApplicationRecord
  belongs_to :user
  validates :message, presence: true,
                      length: { maximum: 80 }
  validates :recipients, presence: true
  validates :minimum_level, presence: true
  validates :maximum_level, presence: true
  serialize :recipients, Array

  scope :recent, -> { where(created_at: 24.hours.ago..Time.now) }
end
