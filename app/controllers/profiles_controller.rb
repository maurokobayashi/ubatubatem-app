class ProfilesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: []

  RESULTS_PER_PAGE = 8

  # GET profiles/:id
  def show
    @profile = Profile.find(params[:id])

    Statistic.track!(@profile, Statistic.events[:perfil_view]) unless current_user? @profile.user

    # instagram scraping
    if @profile.instagram_account.present?
      @instagram_scrap = scrap_from_instagram(@profile.instagram_account.username)
      # override avatar_url on profile
      if @instagram_scrap[:avatar_url] && (@instagram_scrap[:avatar_url] != @profile.avatar_url)
        @profile.avatar_url = @instagram_scrap[:avatar_url]
        @profile.save(touch: false)
      end
    end
  end

  # GET /buscar?q=
  def search
    sleep 0.5
    @query = params[:q]
    if @query.present?
      @profiles = Profile.active.where("title ILIKE ? OR tagline ILIKE ? OR username ILIKE ?", "%#{@query}%", "%#{@query}%", "%#{@query}%")
    else
      @profiles = Profile.none
    end

    # TODO: adicionar no fim da fila os profiles da subcategoria (caso a query ê match)

    @profiles = @profiles.paginate(:page => params[:page], :per_page => RESULTS_PER_PAGE)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def catalogo
    @categs = Categ.ativo.all.order(:order, :name)
    @bairros = Bairro.all.order(:regiao, :id)
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

  private
    def scrap_from_instagram(username)
      instagram_scrap = {}
      response = HTTParty.get("https://www.instagram.com/#{username}/?__a=1")
      logger.debug "[PROFILE::INSTAGRAM SCRAPPING] Response: \n#{response}"
      if response["graphql"].present?
        instagram_scrap[:avatar_url] = response["graphql"]["user"]["profile_pic_url"]
        instagram_scrap[:avatar_url_large] = response["graphql"]["user"]["profile_pic_url_hd"]
        if response["graphql"]["user"]["edge_owner_to_timeline_media"]["count"] > 0
          instagram_scrap[:pictures] = []
          response["graphql"]["user"]["edge_owner_to_timeline_media"]["edges"].each do |post|
            instagram_scrap[:pictures].push({original: post["node"]["thumbnail_src"], thumbnail: post["node"]["thumbnail_resources"].first["src"]})
          end
        end
      end
      return instagram_scrap
    end
end
