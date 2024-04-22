require "rails_helper"

RSpec.describe "Books Search Request" do
  before do
    @headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
  end

  describe "GET api/v1/book-search?location=Atlanta,GA&quantity=5" do
    it 'returns the destination, the forecast, total number of results and a collection of books about the city', :vcr do
      get "/api/v1/book-search?location=Atlanta,GA&quantity=5", headers: @headers

      expect(response).to be_successful
      expect(response.status).to eq 200

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to have_key(:data)
      expect(json[:data]).to be_a(Hash)

      expect(json[:data]).to have_key(:id)
      expect(json[:data][:id]).to eq("null")

      expect(json[:data]).to have_key(:type)
      expect(json[:data][:type]).to eq("books")

      expect(json[:data]).to have_key(:attributes)
      expect(json[:data][:attributes]).to have_key(:destination)
      expect(json[:data][:attributes][:destination]).to eq("Atlanta,GA")

      expect(json[:data][:attributes]).to have_key(:forecast)
      expect(json[:data][:attributes][:destination]).to have_key(:summary)
      expect(json[:data][:attributes][:destination]).to have_key(:temperature)
      
      expect(json[:data][:attributes]).to have_key(:total_books_found)
      expect(json[:data][:attributes][:total_books_found]).to eq(3118)
      
      expect(json[:data][:attributes]).to have_key(:books)
      expect(json[:data][:attributes][:books]).to be_an(Array)
      expect(json[:data][:attributes][:books].count).to eq(5)
    end
  end
end