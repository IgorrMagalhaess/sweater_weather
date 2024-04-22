require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should have_secure_password }
  end

  describe "before_create" do
    it 'generates an API key' do
      user = User.new(email: 'test@example.com', password: 'password', password_confirmation: 'password')

      expect(user.api_key).to eq(nil)

      user.save!
      
      expect(user.api_key).to_not be_nil
    end
  end
end
