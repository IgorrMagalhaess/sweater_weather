class Book
  attr_reader :data

  def initialize(book_data)
    @data = transform_data(book_data)
  end

  def transform_data(data)
    {
      isbn: data[:isbn],
      title: data[:title],
      publisher: data[:publisher]
    }
  end
end