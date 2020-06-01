class LandingPagesController < ApplicationController
  def index
    @categs = Categ.ativo.all.order(:order, :name)
  end
end
