class FeaturesController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:update]

  # PATCH /features/:id
  def update
    success = false
    @feature = Feature.find(params[:id])

    if @feature.present? && authorized?
      if @feature.update( feature_params )
        success = true
      else
        flash.alert = FlashMessages::PROFILE_UPDATE_ERROR
      end
    else
      flash.alert = FlashMessages::NOT_AUTHORIZED
    end

    respond_to do |format|
      format.json do
        render json: flash, status: (success ? 200 : 400)
      end
    end
  end


private
  def feature_params
    params.require(:feature)
      .permit(:delivery, :ponto_comercial, :produtor_local, :plastico, :restricao_etaria,
        :vegetariano, :natural, :vegano, :organico, :lactose, :gluten, :diabetico, :plus_size)
  end

  def authorized?
    current_admin? || is_current_user?(@feature.profile.user)
  end

end