require 'rails_helper'

RSpec.describe Match, type: :model do
  describe "associations" do
    it { should belong_to(:player).class_name('User') }
    it { should belong_to(:opponent).class_name('User') }
    it { should have_many(:user_reviews).dependent(:destroy) }
  end
end
