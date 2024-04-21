require "rails_helper"

RSpec.describe "User Registration", type: :request do
  before do
    @headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
  end

  describe "POST 'api/v1/users" do
    it 'create a new user' do
      user_params = {
        email: 'test@example.com',
        password: 'test',
        password_confirmation: 'test'
      }

      post "/api/v1/users", headers: @headers, params: JSON.generate(user: user_params)

      
    end
  end
end