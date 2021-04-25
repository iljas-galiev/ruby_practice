module TokenAuthHelper
  def current_user
    @current_user ||= User.find_by(token: request.headers["authorization"])
  end

  def logged_in?
    !current_user.nil?
  end
end
