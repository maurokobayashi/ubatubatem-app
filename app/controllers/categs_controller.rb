class CategsController < ApplicationController

  RESULTS_PER_PAGE = 10

  # GET /c/:alias => lista todos os perfis de uma subcategoria
  def show
    @sub_categ = SubCateg.find_by_alias params[:alias]
    if @sub_categ.present?
      @profiles = Profile.where(sub_categ: @sub_categ)
    else
      redirect_to categorias_path and return
    end

    @profiles = @profiles.paginate(:page => params[:page], :per_page => RESULTS_PER_PAGE)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def index
    @categs = Categ.ativo.all.order(:order, :name)
  end

end
