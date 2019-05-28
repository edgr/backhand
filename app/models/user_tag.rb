class UserTag < ApplicationRecord
  belongs_to :users
  belongs_to :tags
end
