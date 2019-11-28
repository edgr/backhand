class Club < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  has_many :users
  has_many :matches
  has_many :courts
end
