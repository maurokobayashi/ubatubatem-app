module SessionsHelper

  def sign_in(user)
    user.refresh_remember_token
    cookies.permanent[Cookies::REMEMBER_TOKEN[:name]] = user.remember_token
    self.current_user = user
  end

  def signed_in?
    current_user.present?
  end

  def sign_out
    self.current_user = nil
    cookies.delete(Cookies::REMEMBER_TOKEN[:name])
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    return @current_user if cookies[:remember_token].blank?
    @current_user ||= User.find_by(remember_token: cookies[Cookies::REMEMBER_TOKEN[:name]])
  end

  def current_user?(user)
    user.present? && user == current_user
  end

  def store_location
    session[:return_to] = request.original_url
  end

end