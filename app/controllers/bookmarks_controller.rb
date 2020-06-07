class BookmarksController < ApplicationController
  before_action :require_authentication,  only: [:index, :create, :destroy]

  RESULTS_PER_PAGE = 10

  def index
    # todo: create bookmark model has_one profile and order by created_at
    @profiles = Profile.aprovado.paginate(:page => params[:page], :per_page => RESULTS_PER_PAGE)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create

  end

  def destroy

  end

end