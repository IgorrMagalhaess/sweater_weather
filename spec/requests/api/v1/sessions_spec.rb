require "rails_helper"

RSpec.describe "Sessions Endpoint", type: :request do
  before do
    @headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
    @user = User.create!(email: 'user@example.com', password: 'password', password_confirmation: 'password')
  end

  describe "POST api/v0/sessions" do
    it 'should respond with the user email and api key' do
      user_params = {
        email: 'user@example.com',
        password: 'password'
      }

      post '/api/v0/sessions', headers: @headers, params: JSON.generate(user: user_params)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      session_response = JSON.parse(response.body, symbolize_names: true)

      expect(session_response).to have_key(:data)
      expect(session_response[:data]).to have_key(:type)
      expect(session_response[:data][:type]).to eq("users")
      expect(session_response[:data][:attributes]).to have_key(:email)
      expect(session_response[:data][:attributes][:email]).to eq("user@example.com")
      expect(session_response[:data][:attributes][:api_key]).to eq(@user.api_key)
    end

    it 'should raise error if wrong password passed' do
      user_params = {
        email: 'user@example.com',
        password: 'password123'
      }

      post '/api/v0/sessions', headers: @headers, params: JSON.generate(user: user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      session_response = JSON.parse(response.body, symbolize_names: true)

      expect(session_response).to have_key(:errors)
      expect(session_response[:errors]).to be_an(Array)

      expect(session_response[:errors].first).to be_a(Hash)
      expect(session_response[:errors].first[:detail]).to eq("Validation Failed: Wrong email or password.")
    end

    it 'should raise error if email is wrong' do
      user_params = {
        email: 'test@example.com',
        password: 'password'
      }

      post '/api/v0/sessions', headers: @headers, params: JSON.generate(user: user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      session_response = JSON.parse(response.body, symbolize_names: true)

      expect(session_response).to have_key(:errors)
      expect(session_response[:errors]).to be_an(Array)

      expect(session_response[:errors].first).to be_a(Hash)
      expect(session_response[:errors].first[:detail]).to eq("Validation Failed: Wrong email or password.")
    end
  end
end