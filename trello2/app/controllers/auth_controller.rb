
class AuthController < ApplicationController

  include AuthHelper

  before_action :not_logged, only: [:new, :create]
  before_action :logged_in?, only: [:destroy]


  protect_from_forgery with: :null_session

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to cards_path
    else
      flash[:danger] = 'Пользователь не найден'
      render 'new'
    end
  end

  def destroy
    def destroy
      log_out
      redirect_to root_url
    end
  end

  private
  def not_logged
    if logged_in?
      redirect_to cards_path
    end
  end
end

