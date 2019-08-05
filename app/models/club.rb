class Club < ApplicationRecord
  has_many :users, :matches
end
