class HomeController < ActionController::Base
  layout "home"
  include AuthHelper
  def index
    if logged_in?
      redirect_to cards_path
    end
  end
end

