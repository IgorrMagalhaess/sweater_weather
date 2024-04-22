require "rails_helper"

RSpec.describe ErrorMessage do
  describe '#initialize' do
    it 'correctly initializes message and status' do
      error_message = ErrorMessage.new('Not Found', 404)

      expect(error_message.message).to eq('Not Found')
      expect(error_message.status).to eq(404)
    end
  end
end