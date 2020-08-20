class SearchCatalogo

  PROFILES_LIMIT = 10
  SUB_CATEGS_LIMIT = 5

  def self.profiles(query, params)
    Profile.active.search_full(query).paginate(page: params[:page], per_page: PROFILES_LIMIT)
  end

  def self.profiles_from_bairro(bairro, params)
    result = Profile.active.joins(:bairro).where(bairros: {alias: bairro.alias}).order(updated_at: :desc)
    if params[:categoria].present?
      result = result.joins(:sub_categ).where(sub_categs: {alias: params[:categoria]})
    end
      result = result.paginate(page: params[:page], per_page: PROFILES_LIMIT)
  end

  def self.profiles_from_sub_categ(sub_categ, params)
    result = Profile.active.where(sub_categ: sub_categ).order(updated_at: :desc)
    if params[:bairro].present?
      result = result.joins(:bairro).where(bairros: {alias: params[:bairro]})
    end
    result = result.paginate(page: params[:page], per_page: PROFILES_LIMIT)
  end

end