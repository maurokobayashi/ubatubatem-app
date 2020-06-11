class ProfilesController < ApplicationController

  before_action :require_authentication,  only: [:edit, :update]

  RESULTS_PER_PAGE = 10

  # GET /profiles/:id/edit
  def edit
    @profile = Profile.find(params[:id])

    if @profile.present? && authorized?
      # setup nested_attributes
      Address.create(profile: @profile) if @profile.address.blank?
      Feature.create(profile: @profile) if @profile.feature.blank?
      InstagramAccount.create(profile: @profile) if @profile.instagram_account.blank?
    else
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
        flash.alert = FlashMessages::PROFILE_UPDATE_ERROR
        redirect_back fallback_location: edit_profile_path(@profile)
      end
    else
      flash.alert = FlashMessages::NOT_AUTHORIZED
      redirect_back fallback_location: root_path
    end
  end

private
  def profile_params
    params.require(:profile).permit(
      :avatar_url, :bio, :employees_qty, :phone_secondary, :search_tags, :status, :sub_categ_id,
      :tagline, :title, :user_id, :username, :website, :whatsapp,
      address_attributes: [:id, :bairro_id, :logradouro, :numero, :complemento], # important: include nested object's id to force update instead of delete and insert
      instagram_account_attributes: [:id, :username, :instagram_user_id, :access_token],
      opening_hours_attributes: [:_destroy, :id, :day, :opens_at, :closes_at] #important: _destroy (true) means the object should be destroyed
    )
  end

  def authorized?
    current_admin? || is_current_user?(@profile.user)
  end

end
