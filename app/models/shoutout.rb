class Shoutout < ApplicationRecord
  belongs_to :user
  validates :message, presence: true,
                      length: { maximum: 80 }
end
