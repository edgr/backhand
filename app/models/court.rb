class Court < ApplicationRecord
  belongs_to :club, optional: true
end
