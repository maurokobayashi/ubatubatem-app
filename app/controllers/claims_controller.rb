class ClaimsController < ApplicationController

  before_action :require_authentication,  only: [:create]

# GET /reivindicar/:uuid
  def confirm

  end

  # POST /claims
  def create
    requester = current_user
    profile = Profile.find(claim_params[:profile_id])

    if requester.is_business?
      flash.alert = FlashMessages::CLAIM_USER_ALREADY_HAS_PROFILE
      redirect_back fallback_location: root_path

    elsif profile.present? && profile.reivindicado?
      flash.alert = FlashMessages::CLAIM_PROFILE_ALREADY_CLAIMED
      redirect_back fallback_location: root_path

    else
      claim = Claim.new(claim_params)
      claim.requester = requester
      claim.save
      redirect_to claim_path claim
    end
  end


  # GET /:username/reivindicar
  def new
    @profile = Profile.find_by(username: params[:username])
    if @profile.present? && !@profile.reivindicado?
      @claim = Claim.new(profile: @profile)
      render
    else
      redirect_back fallback_location: root_path
    end
  end

  # GET /claims/:id
  def show
    @claim = Claim.find(params[:id])
  end



private
  def claim_params
    params.require(:claim).permit(:profile_id, :user_id)
  end

end