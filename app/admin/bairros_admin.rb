Trestle.resource(:bairros) do
  menu do
    item :bairros, icon: "fa fa-map-marker", group: "configurações"
  end

  form do |bairro|
    text_field :name
    select :regiao, Bairro.regiaos.keys.to_a
    row do
      col { text_field :lat }
      col { text_field :lng }
    end
  end

end
