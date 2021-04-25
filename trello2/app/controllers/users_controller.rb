class UsersController < ApplicationController
  include AuthHelper
  before_action :not_logged, only: [:new, :create]
  protect_from_forgery with: :null_session

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save

      log_in @user
      flash[:success] = "Успешно!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  private

  def not_logged
    if logged_in?
      redirect_to cards_path
    end
  end
end

