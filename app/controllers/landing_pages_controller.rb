class LandingPagesController < ApplicationController

  # GET /sobre-nos
  def about_us

  end

  # GET /
  def index
    @categs = Categ.ativo.all.order(:order, :name)
  end

end
