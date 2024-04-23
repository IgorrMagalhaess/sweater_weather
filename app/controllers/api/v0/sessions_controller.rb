class Api::V0::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      render json: UsersSerializer.new(user)
    else
      message = "Validation Failed: Wrong email or password."
      render json: ErrorSerializer.new(ErrorMessage.new(message, 400)).
      serialize_json, status: :bad_request
    end
  end
end