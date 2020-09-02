class ListsController < ApplicationController

  RESULTS_PER_PAGE = 10

  # GET /destaques/:alias
  def show
    @list = List.find_by_alias params[:alias]
    if @list.present?
      @profiles = Profile.where(id: @list.profile_ids)
    else
      redirect_to root_path
    end
  end

end