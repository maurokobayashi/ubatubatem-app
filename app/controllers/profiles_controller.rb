class ProfilesController < ApplicationController

  RESULTS_PER_PAGE = 10

  # GET /:username
  def show
    @profile = Profile.find_by(username: params[:username])
    if @profile
      Statistic.track!(@profile, Statistic.events[:perfil_view]) unless current_user? @profile.user
    else
      render "not_found"
    end
  end

end
