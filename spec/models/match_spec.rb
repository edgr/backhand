require 'rails_helper'

RSpec.describe Match, type: :model do
  describe "associations" do
    it { should belong_to(:player).class_name('User') }
    it { should belong_to(:opponent).class_name('User') }
    it { should have_many(:user_reviews).dependent(:destroy) }
  end
  describe "validations" do
    it { should validate_presence_of(:player) }
    it { should validate_presence_of(:opponent) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:score) }
    it { should validate_presence_of(:winner) }
    it { should validate_presence_of(:loser) }
  end
end
