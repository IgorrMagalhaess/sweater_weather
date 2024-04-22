class BooksSerializer
  def initialize(destination, forecast, total_books_found, books)
    @destination = destination
    @forecast = forecast
    @total_books_found = total_books_found
    @books = books
  end

  def serialize
    {
      data: {
        id: "null",
        type: "books",
        attributes: {
          destination: @destination,
          forecast: @forecast,
          total_books_found: @total_books_found,
          books: serialize_books
        }
      }
    }
  end

  private

  def serialize_books
    @books.map do |book|
      serialized_book = {
        title: book.data[:title]
      }
      serialized_book[:isbn] = book.data[:isbn] if book.data[:isbn].present?
      serialized_book[:publisher] = book.data[:publisher] if book.data[:publisher].present?
      serialized_book
    end
  end
end
