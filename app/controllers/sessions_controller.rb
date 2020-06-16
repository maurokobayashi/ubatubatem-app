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
    username = session_params[:username].strip.downcase
    password = session_params[:password].strip.downcase

    profile = Profile.find_by(username: username)
    if profile.present?
      user = profile.user
      if user.present?
        if user.authenticate(session_params[:password])
          @user = user
          sign_in @user
          flash.notice = FlashMessages::SIGNIN_SUCCESS
          logger.info("[SIGNIN::SUCCESS] User: #{@user.id} - #{@user.profile.username}")
          redirect_to (get_stored_path || profile.profile_path)
        else
          flash.alert = FlashMessages::SIGNIN_INVALID_PASSWORD
          logger.info("[SIGNIN::ERROR] Params: #{session_params}. Motivo: #{FlashMessages::SIGNIN_INVALID_PASSWORD}")
        end

      # Profile não tem user
      else
        # TODO
      end
    # username não existe
    else
      flash.alert = FlashMessages::SIGNIN_INVALID_USERNAME
      logger.info("[SIGNIN::ERROR] Params: #{session_params}. Motivo: #{FlashMessages::SIGNIN_INVALID_USERNAME}")
      return
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
    params.require(:session).permit(:username, :email, :password)
  end

end