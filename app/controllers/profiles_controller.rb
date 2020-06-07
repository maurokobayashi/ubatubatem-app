class ProfilesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: []

  RESULTS_PER_PAGE = 8

  ###############################################

  def catalogo
    @categs = Categ.ativo.all.order(:order, :name)
    @bairros = Bairro.all.order(:regiao, :id)
  end

  # GET /bairro/:alias => lista todos os perfis de uma subcategoria
  def catalogo_bairro
    @bairro = Bairro.find_by_alias params[:alias]
    if @bairro.present?
      @profiles = Profile.active.joins(:bairro).where(bairros: {alias: params[:alias]})
    else
      redirect_to catalogo_path and return
    end

    @profiles = @profiles.paginate(:page => params[:page], :per_page => RESULTS_PER_PAGE)
    @categs = Categ.ativo.all.order(:order, :name)

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /categoria/:alias => lista todos os perfis de uma subcategoria
  def catalogo_categoria
    @sub_categ = SubCateg.find_by_alias params[:alias]
    if @sub_categ.present?
      @profiles = Profile.active.where(sub_categ: @sub_categ)
    else
      redirect_to catalogo_path and return
    end

    @profiles = @profiles.paginate(:page => params[:page], :per_page => RESULTS_PER_PAGE)

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /buscar?q=
  def search
    @query = params[:q]
    if @query.present?
      @profiles = Profile.active.where("title ILIKE ? OR tagline ILIKE ? OR username ILIKE ?", "%#{@query}%", "%#{@query}%", "%#{@query}%")
      @sub_categs = SubCateg.ativo.where("name ILIKE ? OR search_tags ILIKE ?", "%#{@query}%", "%#{@query}%")
    else
      @profiles = Profile.none
      @sub_categs = SubCateg.none
    end

    # TODO: adicionar no fim da fila os profiles da subcategoria (caso a query dê match)
    @profiles = @profiles.paginate(:page => params[:page], :per_page => RESULTS_PER_PAGE)

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /:username
  def show
    @profile = Profile.find_by(username: params[:username])
    if @profile
      Statistic.track!(@profile, Statistic.events[:perfil_view]) unless current_user? @profile.user
    else
      render "not_found"
    end
  end


  # GET /buscar_full?q=
  # def fullsearch
  #   per_page = 10
  #   @query = params[:q]
  #   if @query.present?
  #     @profiles = Profile.search_full(@query)
  #   else
  #     @profiles = Profile.none
  #   end

  #   @profiles = @profiles.paginate(:page => params[:page], :per_page => per_page)

  #   respond_to do |format|
  #     format.html
  #     format.js
  #   end

  #   render "search"
  # end

end
