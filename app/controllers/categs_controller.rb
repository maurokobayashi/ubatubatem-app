class CategsController < ApplicationController
  RESULTS_PER_PAGE = 10
  # GET /c/:alias => lista todos os perfis de uma subcategoria
  def categoria
    sleep 0.5

    @sub_categ = SubCateg.find_by_alias params[:alias]
    if @sub_categ.present?
      @profiles = Profile.where(sub_categ: @sub_categ)
    else
      # @profiles = Profile.none

      # fake
      @sub_categ = SubCateg.first
      @profiles = Profile.where("title ILIKE ? OR tagline ILIKE ?", "%a%", "%burger%").order("RANDOM()")
    end

    @profiles = @profiles.paginate(:page => params[:page], :per_page => RESULTS_PER_PAGE)

    respond_to do |format|
      format.html
      format.js
    end
  end

end
