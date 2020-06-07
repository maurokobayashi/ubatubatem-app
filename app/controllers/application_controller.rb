class ApplicationController < ActionController::Base
  include SessionsHelper

  protect_from_forgery with: :exception

private
  def require_authentication
    store_current_path
    redirect_to signin_path redirect: false unless signed_in?
  end
end
