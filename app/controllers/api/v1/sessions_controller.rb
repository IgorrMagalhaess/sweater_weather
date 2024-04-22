class Api::V1::SessionsController < ApplicationController
  before_action :find_user, only: [:create]
  
  def create
    if @user && @user.authenticate(params[:user][:password])
      render json: UsersSerializer.new(@user)
    else
      message = "Validation Failed: Wrong email or password."
      render json: ErrorSerializer.new(ErrorMessage.new(message, 400)).
      serialize_json, status: :bad_request
    end
  end

  private
  def find_user
    @user = User.find_by(email: params[:user][:email])
    raise ActiveRecord::RecordNotFound, "User not found" unless @user    
  end
end