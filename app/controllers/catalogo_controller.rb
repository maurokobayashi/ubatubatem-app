class CatalogoController < ApplicationController

  RESULTS_PER_PAGE = 10

  ###############################################

  # GET /bairro/:alias?categoria=:c => lista todos os perfis de uma subcategoria
  def catalogo_bairro
    @bairro = Bairro.find_by_alias params[:alias]
    if @bairro.present?
      @profiles = SearchCatalogo.profiles_from_bairro @bairro, params
      @filtros = @profiles.map{ |p| [p.sub_categ.name, p.sub_categ.alias] if p.sub_categ.present? && p.sub_categ.ativo? }.compact.uniq.sort
    else
      redirect_to catalogo_path and return
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /categoria/:alias?bairro=b => lista todos os perfis de uma subcategoria
  def catalogo_categoria
    @sub_categ = SubCateg.find_by_alias params[:alias]
    if @sub_categ.present?
      @profiles = SearchCatalogo.profiles_from_sub_categ @sub_categ, params
      @filtros = @profiles.map{ |p| [p.bairro.name, p.bairro.alias] if p.bairro.present? }.compact.uniq.sort
    else
      redirect_to catalogo_path and return
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /catalogo
  def index
    current_user.update_last_login if signed_in?
    @categs = Categ.ativo.all.order(:order, :name)
    @bairros = Bairro.all.order(:regiao, :id)
  end

  # GET /buscar?q='a'&page=1
  def search
    @query = params[:q]
    if @query.present?
      @profiles = SearchCatalogo.profiles(@query, params)
      @result_count = @profiles.count

      SearchHistory.track!(current_user, @query, @result_count)
    else
      # will_paginate needs it
      @profiles = Profile.none
      @sub_categs = SubCateg.none
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

end