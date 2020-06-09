class ApplicationController < ActionController::Base
  include SessionsHelper

  protect_from_forgery with: :exception

private
  def require_authentication
    store_current_path
    unless signed_in?
      flash.notice = FlashMessages::NOT_AUTHENTICATED
      redirect_to signin_path
    end
  end

end
