Trestle.resource(:categs) do
  menu do
    item :categs, icon: "fa fa-filter", label: "Categorias", group: "Configurações"
  end

  search do |query|
    query ? Categ.where("name ILIKE ? OR search_tags ILIKE ?","%#{query}%", "%#{query}%") : Categ.all
  end

end
