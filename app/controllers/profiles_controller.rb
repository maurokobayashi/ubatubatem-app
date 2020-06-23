class ProfilesController < ApplicationController

  before_action :require_authentication,  only: [:edit, :update]
  skip_before_action :verify_authenticity_token, only: [:update_avatar]

  RESULTS_PER_PAGE = 10

  # GET /:username/editar
  def edit
    @profile = Profile.find_by(username: params[:username])

    if @profile.present? && authorized?
      # setup nested_attributes
      Address.create(profile: @profile) if @profile.address.blank?
      Feature.create(profile: @profile) if @profile.feature.blank?
      InstagramAccount.create(profile: @profile) if @profile.instagram_account.blank?
      @profile.setup_opening_hours
    else
      flash.alert = FlashMessages::NOT_AUTHORIZED
      redirect_back fallback_location: root_path
    end
  end

  # GET /ping
  def random
    profile = Profile.order("RANDOM()").limit(1).first
    redirect_to profile_path(profile.username)
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
        flash.alert = FlashMessages::PROFILE_UPDATE_ERROR
        redirect_back fallback_location: edit_profile_path(@profile)
      end
    else
      flash.alert = FlashMessages::NOT_AUTHORIZED
      redirect_back fallback_location: root_path
    end
  end

  # PATCH /profiles/:id/avatar
  def update_avatar
    success = true
    msg = ""
    profile = Profile.find(params[:id])

    if profile.present? && profile.update(avatar_url: profile_params[:avatar_url])
      msg = FlashMessages::PROFILE_AVATAR_UPDATE_SUCCESS
    else
      success = false
      msg = FlashMessages::PROFILE_AVATAR_UPDATE_ERROR
    end

    respond_to do |format|
      format.json do
        render json: {msg: msg}, status: (success ? 200 : 400)
      end
    end
  end

private
  def profile_params
    params.require(:profile).permit(
      :avatar_url, :bio, :employees_qty, :phone_secondary, :search_tags, :status, :sub_categ_id,
      :tagline, :title, :user_id, :username, :website, :whatsapp,
      address_attributes: [:id, :bairro_id, :logradouro, :numero, :complemento], # important: include nested object's id to force update instead of delete and insert
      instagram_account_attributes: [:id, :username, :instagram_user_id, :access_token],
      opening_hours_attributes: [:id, :day, :opens_at, :closes_at, :closed] #important: _destroy (true) means the object should be destroyed
    )
  end

  def authorized?
    current_admin? || is_current_user?(@profile.user)
  end

end
