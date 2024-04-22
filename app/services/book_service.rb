class BookService
  def conn
    conn = Faraday.new("https://openlibrary.org") do |f|
      f.headers["Accept"] = "application/json"
    end
  end

  def get_url(url)
    response = conn.get(url)

    JSON.parse(response.body, symbolize_names: true)
  end

  def get_books(location)
    get_url("/search.json?q=#{location}") 
  end
end