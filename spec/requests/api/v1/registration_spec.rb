require "rails_helper"

RSpec.describe "User Registration", type: :request do
  before do
    @headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
  end

  describe "POST 'api/v1/users" do
    it 'create a new user when valid params are passed' do
      user_params = {
        email: 'test@example.com',
        password: 'test',
        password_confirmation: 'test'
      }

      post "/api/v1/users", headers: @headers, params: JSON.generate(user: user_params)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      registration_response = JSON.parse(response.body, symbolize_names: true)

      expect(registration_response).to have_key(:data)
      expect(registration_response[:data]).to be_a(Hash)

      expect(registration_response[:data]).to have_key(:type)
      expect(registration_response[:data][:type]).to eq("users")
      expect(registration_response[:data][:id]).to be_a(Integer)

      expect(registration_response[:data][:attributes]).to have_key(:email)
      expect(registration_response[:data][:attributes]).to have_key(:api_key)
      expect(registration_response[:data][:attributes]).to_not have_key(:password)
    end
  end
end