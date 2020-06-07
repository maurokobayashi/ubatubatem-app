Trestle.resource(:deliveries) do
  build_instance do |attrs, params|
    attrs[:profile] = Profile.find(params[:profile_id]) if params[:profile_id]
    Delivery.new(attrs)
  end

  menu do
    item :deliveries, icon: "fa fa-biking", label: "Delivery", group: "dados da conta"
  end

  table do
    column :profile, link: false
    column :has_delivery, header: "Delivery"
    column :has_retirada, header: "Retirada"
    column :has_ponto_comercial, header: "Ponto comercial"
    column :bairro_ids, ->(delivery) { content_tag(:small, Bairro.where(id: delivery.bairro_ids).map(&:name).join(", "), class: "text-muted hidden-xs") }, header: "Locais de entrega"
    actions
  end

  form do
    select :profile_id, Profile.all
    check_box :has_delivery?, label: "Faz delivery"
    check_box :has_retirada?, label: "Retirada no local"
    check_box :has_ponto_comercial?, label: "Tem ponto comercial"
    divider
    select :bairro_ids, Bairro.all, { label: "Locais de entrega" }, multiple: true
  end

end
