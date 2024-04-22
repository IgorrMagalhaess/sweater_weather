require "rails_helper"

RSpec.describe BookService do
  describe "#get_books" do
    it "returns a list of books based on argument", :vcr do
      book_service = BookService.new
      books = book_service.get_books("ruby")
      
      expect(books).to be_a(Hash)
      expect(books).to have_key(:numFound)
      expect(books).not_to be_empty

      book = books[:docs].first
      expect(book).to have_key(:title)
      expect(book).to have_key(:author_name)
      expect(book).to have_key(:publisher)
      expect(book).to have_key(:isbn)
    end
  end
end