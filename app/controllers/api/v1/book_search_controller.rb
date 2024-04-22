class Api::V1::BookSearchController < ApplicationController
  def index
    destination = params[:location]
    quantity = params[:quantity]

    forecast = ForecastFacade.new(destination).forecast.resumed_forecast
    book_facade = BooksFacade.new(destination, quantity)

    total_books = book_facade.total_books_found
    book_search = book_facade.books

    render json: BooksSerializer.new(
      destination, 
      forecast, 
      total_books, 
      book_search).serialize
  end
end