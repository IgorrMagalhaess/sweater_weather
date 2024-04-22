class BooksFacade
  attr_reader :total_books_found

  def initialize(location, quantity, service = BookService.new)
    @location = location
    @quantity = quantity.to_i
    @service = service
    load_books
  end

  def books
    @books ||= load_books
  end

  private

  def load_books
    books_json = @service.get_books(@location)
    @total_books_found = books_json[:numFound]
    books = books_json[:docs].take(@quantity)
    @books = books.map { |book_data| Book.new(book_data) }
  end
end
