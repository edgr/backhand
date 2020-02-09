class ComputedSkillsSet < ApplicationRecord
  belongs_to :user, dependent: :destroy
  validates :user_id, presence: true
end
