class ApplicationController < ActionController::Base
  include SessionsHelper

  protect_from_forgery with: :exception

private
  def render_not_found
    render :file => "#{Ubatubatem::Application.config.root_url}/public/404.html",  :status => 404
  end

  def require_authentication
    store_location
    redirect_to new_session_path unless signed_in?
  end
end
