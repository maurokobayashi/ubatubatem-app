class StatisticsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:track_profile]

  # POST /statistics?profile_id=?&event=?
  def track_profile
    if params[:profile_id].present? && params[:event].present?
      Statistic.create!(profile: Profile.find(params[:profile_id]), event: params[:event].to_i)
    end

    head :ok
  end

end
