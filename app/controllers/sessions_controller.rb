class SessionsController < ApplicationController

  # GET /entrar
  def new
    if signed_in?
      flash.notice = FlashMessages::SIGNIN_SUCCESS
      redirect_to (get_stored_path || root_path)
    else
      store_referer_path
    end
  end

  # POST /login
  def create
    login = session_params[:login].strip.downcase
    password = session_params[:password].strip.downcase
    redirect_path = get_stored_path || root_path

    user = User.left_outer_joins(:profile).where(email: login)
      .or(User.left_outer_joins(:profile).where(profiles: {username: login}))
      .first

    if user.present?
      if user.authenticate(session_params[:password])
        @user = user
        sign_in @user
        flash.notice = FlashMessages::SIGNIN_SUCCESS
        logger.info("[SIGNIN::SUCCESS] User: #{@user.id} - #{@user.email}")
        redirect_to (user.profile.present? ? user.profile.profile_path : redirect_path)
      else
        flash.alert = FlashMessages::SIGNIN_INVALID_PASSWORD
        logger.info("[SIGNIN::ERROR] Params: #{session_params}. Motivo: #{FlashMessages::SIGNIN_INVALID_PASSWORD}")
        redirect_back fallback_location: signin_path
      end
    else
      flash.alert = FlashMessages::SIGNIN_INVALID_USERNAME
      logger.info("[SIGNIN::ERROR] Params: #{session_params}. Motivo: #{FlashMessages::SIGNIN_INVALID_USERNAME}")
      redirect_back fallback_location: signin_path
    end
  end

  # GET /signout
  def destroy
    store_referer_path

    sign_out
    flash.notice = FlashMessages::SIGNOUT_SUCCESS
    redirect_to (get_stored_path || root_path)
  end

private
  def session_params
    params.require(:session).permit(:login, :password)
  end

end