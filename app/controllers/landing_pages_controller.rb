class LandingPagesController < ApplicationController

  # GET /sobre-nos
  def about_us

  end

  # GET /
  def index
    @categs = Categ.ativo.order(:order, :name)
    @lists = List.ativo.order(priority: :desc, created_at: :desc)
  end

end
