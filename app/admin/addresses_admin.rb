Trestle.resource(:addresses) do
  menu do
    group :catálogo do
      item :addresses, icon: "fa fa-map-marker", label: "Endereços"
    end
  end

  search do |query|
    query ? Address.where("logradouro ILIKE ? OR bairro ILIKE ?", "%#{query}%", "%#{query}%") : Address.all
  end


end
