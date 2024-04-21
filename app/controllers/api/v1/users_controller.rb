class Api::V1::UsersController < ApplicationController
  def create
    begin
      user = User.create!(user_params)
      render json: UsersSerializer.new(user), status: :created
    rescue ActiveRecord::RecordInvalid => error
      render json: ErrorSerializer.new(ErrorMessage.new(error.message, 400)).serialize_json, status: :bad_request
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end