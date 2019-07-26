require 'rails_helper'

RSpec.describe User, type: :model do
  describe User, '#full_name' do
    it 'returns the first and last name capitalized' do
      user = User.new(first_name: 'bOBBy', last_name: "boBSon")
      expect(user.full_name).to eq 'Bobby Bobson'
    end
  end
end
