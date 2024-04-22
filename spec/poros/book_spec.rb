require "rails_helper"

RSpec.describe Book do
  before(:each) do
    @book_data = {
      isbn: '978-0132350884',
      title: 'The Ruby Programming Language',
      publisher: 'O\'Reilly Media'
    }

    @book = Book.new(@book_data)
  end

  describe '#initialize' do
    it 'correctly initializes book data' do
      expect(@book.data[:isbn]).to eq('978-0132350884')
      expect(@book.data[:title]).to eq('The Ruby Programming Language')
      expect(@book.data[:publisher]).to eq('O\'Reilly Media')
    end
  end
end
