require "rails_helper"

RSpec.describe BooksFacade do
  describe '#initialize' do
    it 'creates a BooksFacade object', :vcr do
      facade = BooksFacade.new("New York", 5)

      expect(facade).to be_an_instance_of(BooksFacade)
    end
  end

  describe '#books' do
    it 'calls get_books on service and returns an array of Book objects', :vcr do
      facade = BooksFacade.new("New York", 5)

      books = facade.books

      expect(books).to be_an(Array)
      expect(books.length).to eq(5)
      expect(books.first).to be_an_instance_of(Book)
      expect(facade.total_books_found).to be_a(Integer)
    end
  end
end
