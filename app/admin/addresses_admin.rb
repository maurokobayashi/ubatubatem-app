Trestle.resource(:addresses) do
  build_instance do |attrs, params|
    attrs[:profile] = Profile.find(params[:profile_id]) if params[:profile_id]
    Address.new(attrs)
  end

  menu do
    item :addresses, icon: "fa fa-map-marker", label: "Endereços", group: "dados cadastrados"
  end

  search do |query|
    query ? Address.where("logradouro ILIKE ?", "%#{query}%") : Address.all
  end


end
