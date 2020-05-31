class ApplicationController < ActionController::Base
  include SessionsHelper

  protect_from_forgery with: :exception

private
  def require_authentication
    store_location
    redirect_to new_session_path unless signed_in?
  end
end
