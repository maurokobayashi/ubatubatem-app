class ProfilesController < ApplicationController

  before_action :require_authentication,  only: [:edit, :update]

  RESULTS_PER_PAGE = 10

  # GET /profiles/:id/edit
  def edit
    @profile = Profile.find(params[:id])

    unless @profile.present? && authorized?
      flash.alert = FlashMessages::NOT_AUTHORIZED
      redirect_back fallback_location: root_path
    end
  end

  # GET /:username
  def show
    @profile = Profile.find_by(username: params[:username])
    if @profile
      Statistic.track!(@profile, Statistic.events[:perfil_view]) unless is_current_user? @profile.user
    else
      render "not_found"
    end
  end

  # PATCH /profiles/:id
  def update
    @profile = Profile.find(params[:id])

    if @profile.present? && authorized?
      if @profile.update( profile_params )
        flash.notice = FlashMessages::PROFILE_UPDATE_SUCCESS
        redirect_back fallback_location: edit_profile_path(@profile)
      else
        flash.warn = FlashMessages::PROFILE_UPDATE_ERROR
        redirect_back fallback_location: edit_profile_path(@profile)
      end
    else
      flash.alert = FlashMessages::NOT_AUTHORIZED
      redirect_back fallback_location: root_path
    end
  end

private
  def profile_params
    params.require(:profile).permit(:username, :title, :tagline, :bio, :whatsapp, :phone_secondary, :status, :website, :avatar_url, :sub_categ_id, :user_id)
  end

  def authorized?
    current_admin? || is_current_user?(@profile.user)
  end

end
