class CatalogoController < ApplicationController

  RESULTS_PER_PAGE = 10

  ###############################################

  # GET /bairro/:alias => lista todos os perfis de uma subcategoria
  def catalogo_bairro
    @bairro = Bairro.find_by_alias params[:alias]
    if @bairro.present?
      @profiles = SearchCatalogo.profiles_from_bairro @bairro, params[:page]
      @categs = Categ.ativo.all.order(:order, :name)
    else
      redirect_to catalogo_path and return
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /categoria/:alias => lista todos os perfis de uma subcategoria
  def catalogo_categoria
    @sub_categ = SubCateg.find_by_alias params[:alias]
    if @sub_categ.present?
      @profiles = SearchCatalogo.profiles_from_sub_categ @sub_categ, params[:page]
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
    @categs = Categ.ativo.all.order(:order, :name)
    @bairros = Bairro.all.order(:regiao, :id)
  end

  # GET /buscar?q='a'&page=1
  def search
    @query = params[:q]
    if @query.present?
      @profiles = SearchCatalogo.profiles_broad_match @query, params[:page]
      @sub_categs = SearchCatalogo.sub_categs @query
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