require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.new(email: 'a@a.a', password: 'password')
  end

  describe 'validations' do
    it 'should not let a user be created without an email' do
      @user.email = nil
      expect(@user).to_not be_valid
    end
    it 'should not let a user be created without a phone number' do
      @user.phone_number = nil
      expect(@user).to_not be_valid
    end
  end

  describe 'validations on update' do
    it 'should not allow negative ages' do
      @user.birthday = Date.tomorrow
      expect(@user).to_not be_valid
    end
  end

  describe 'methods' do
    describe User, '#full_name' do
      it 'returns the first and last name capitalized' do
        user = User.new(first_name: 'bOBBy', last_name: "boBSon")
        expect(user.full_name).to eq 'Bobby Bobson'
      end
    end
  end
end
