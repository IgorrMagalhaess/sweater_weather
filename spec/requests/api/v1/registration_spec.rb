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
      expect(registration_response[:data][:id]).to be_a(String)

      expect(registration_response[:data][:attributes]).to have_key(:email)
      expect(registration_response[:data][:attributes]).to have_key(:api_key)
      expect(registration_response[:data][:attributes]).to_not have_key(:password)
    end

    it 'raises 400 error if passwords dont match' do
      user_params = {
        email: 'test@example.com',
        password: 'test',
        password_confirmation: 'wrong'
      }

      post "/api/v1/users", headers: @headers, params: JSON.generate(user: user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      registration_response = JSON.parse(response.body, symbolize_names: true)

      expect(registration_response).to have_key(:errors)
      expect(registration_response[:errors]).to be_an(Array)

      expect(registration_response[:errors].first).to be_a(Hash)
      expect(registration_response[:errors].first[:detail]).to eq("Validation failed: Password confirmation doesn't match Password, Password confirmation doesn't match Password")
    end

    it 'raises 400 error if email is already taken' do
      user_1 = create(:user, email: 'user@example.com', password: 'password', password_confirmation: 'password')

      user_params = {
        email: 'user@example.com',
        password: 'test',
        password_confirmation: 'test'
      }

      post "/api/v1/users", headers: @headers, params: JSON.generate(user: user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      registration_response = JSON.parse(response.body, symbolize_names: true)

      expect(registration_response).to have_key(:errors)
      expect(registration_response[:errors]).to be_an(Array)

      expect(registration_response[:errors].first).to be_a(Hash)
      expect(registration_response[:errors].first[:detail]).to eq("Validation failed: Email has already been taken")
    end

    it 'raises 400 error if field is missing' do
      user_1 = create(:user, email: 'user@example.com', password: 'password', password_confirmation: 'password')

      user_params = {
        password: 'test',
        password_confirmation: 'test'
      }

      post "/api/v1/users", headers: @headers, params: JSON.generate(user: user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      registration_response = JSON.parse(response.body, symbolize_names: true)

      expect(registration_response).to have_key(:errors)
      expect(registration_response[:errors]).to be_an(Array)

      expect(registration_response[:errors].first).to be_a(Hash)
      expect(registration_response[:errors].first[:detail]).to eq("Validation failed: Email can't be blank")
    end
  end
end