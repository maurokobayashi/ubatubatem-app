class ProfilesController < ApplicationController
  def index
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def sample(limit)
    @profiles = Profile.all.sample(limit)
  end
end
