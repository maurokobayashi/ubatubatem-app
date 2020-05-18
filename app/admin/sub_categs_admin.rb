Trestle.resource(:sub_categs) do
  menu do
    item :sub_categs, icon: "fa fa-layer-group", label: "Sub-categorias", group: "Configurações"
  end

  search do |query|
    query ? SubCateg.where("name ILIKE ? OR search_tags ILIKE ?","%#{query}%", "%#{query}%") : SubCateg.all
  end

end
