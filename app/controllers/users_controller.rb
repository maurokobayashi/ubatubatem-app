class UsersController < ApplicationController

  # GET /minha-conta
  def edit

  end

  # GET /cadastrar
  def new
    params[:return_to].present? ? store_return_to_path(params[:return_to]) : store_referer_path
    @user = User.new
  end

  # POST /signup
  def create
    if User.exists?(email: user_params[:email])
      flash.notice = FlashMessages::SIGNUP_ALREADY_EXISTS
      params = Hash[:login, user_params[:email]]
      redirect_to controller: 'sessions', action: 'new', params: params
    else
      if user_params[:password] == user_params[:password_confirmation]
        @user = User.create(user_params)
        sign_in @user
        flash.notice = FlashMessages::SIGNUP_SUCCESS
        logger.info("[SIGNUP::SUCCESS] User: #{@user.id} - #{@user.email}")
        redirect_to get_stored_path
      else
        flash.alert = FlashMessages::SIGNUP_PASSWORD_UNMATCH
        params = Hash[:email, user_params[:email]]
        redirect_back fallback_location: new_user_path
      end
    end
  end

  # GET /senha
  def password_forgot

  end

private
  def user_params
    params[:user][:email] = params[:user][:email].strip.downcase if params[:user][:email].present?
    params[:user][:password] = params[:user][:password].strip.downcase if params[:user][:password].present?
    params[:user][:password_confirmation] = params[:user][:password_confirmation].strip.downcase if params[:user][:password_confirmation].present?

    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
  end

end
