class ApplicationController < ActionController::Base
  include SessionsHelper

  protect_from_forgery with: :exception

private
  def require_authentication
    store_location
    redirect_to signin_path unless signed_in?
  end
end
