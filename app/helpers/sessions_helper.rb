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
    return @current_user if cookies[Cookies::REMEMBER_TOKEN[:name]].blank?
    @current_user ||= User.find_by(remember_token: cookies[Cookies::REMEMBER_TOKEN[:name]])
  end

  def is_current_user?(user)
    user.present? && user == current_user
  end

  def current_admin?
    signed_in? && current_user.try(:admin?)
  end

  def store_referer_path
    session[:return_to] = request.referer
  end

  def store_current_path
    session[:return_to] = request.original_url
  end

  def store_return_to_path(return_to)
    session[:return_to] = return_to
  end

  def get_stored_path
    session.delete(:return_to)
  end

end