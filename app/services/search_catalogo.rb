class SearchCatalogo
  #TODO: order!

  PROFILES_LIMIT = 10
  SUB_CATEGS_LIMIT = 5

  def self.profiles(query, params)
    Profile.active
      .where("title ILIKE ? OR tagline ILIKE ? OR username ILIKE ? OR search_tags ILIKE ?", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
      .paginate(page: params[:page], per_page: PROFILES_LIMIT)
  end

  # retorna profiles que contém o termo de busca ou cujas subcategorias contém o termo de busca
  def self.profiles_broad_match(query, params)
    sub_categ_ids = SearchCatalogo.sub_categs(query).map{|sc| sc.id}

    Profile.active.where("title ILIKE ? OR tagline ILIKE ? OR username ILIKE ? OR search_tags ILIKE ?", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
      .or(Profile.active.where(sub_categ_id: sub_categ_ids))
      .paginate(page: params[:page], per_page: PROFILES_LIMIT)
  end

  def self.profiles_from_bairro(bairro, params)
    result = Profile.active.joins(:bairro)
      .where(bairros: {alias: bairro.alias})
    if params[:categoria].present?
      result = result.joins(:sub_categ).where(sub_categs: {alias: params[:categoria]})
    end
      result = result.paginate(page: params[:page], per_page: PROFILES_LIMIT)
  end

  def self.profiles_from_sub_categ(sub_categ, params)
    result = Profile.active.where(sub_categ: sub_categ)
    if params[:bairro].present?
      result = result.joins(:bairro).where(bairros: {alias: params[:bairro]})
    end
    result = result.paginate(page: params[:page], per_page: PROFILES_LIMIT)
  end

  def self.sub_categs(query)
    SubCateg.ativo
      .where("name ILIKE ? OR search_tags ILIKE ?", "%#{query}%", "%#{query}%")
      .limit(SUB_CATEGS_LIMIT)
  end

end