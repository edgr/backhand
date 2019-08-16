class MatchSet < ApplicationRecord
  belongs_to :match, optional: true

  # validates_presence_of :score
end
