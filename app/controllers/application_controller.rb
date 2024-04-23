class ApplicationController < ActionController::API
  rescue_from  ActiveRecord::RecordInvalid, with: :bad_request_response

  private
  def bad_request_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 400))
    .serialize_json, status: :bad_request
  end
end
