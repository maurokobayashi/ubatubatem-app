Trestle.resource(:lists) do
  menu do
    item :lists, icon: "fa fa-star", label: "Destaques"
  end

  search do |query|
    query ? List.where("title ILIKE ? OR subtitle ILIKE ?","%#{query}%", "%#{query}%") : List.all
  end

  form do |list|
    text_field :cover_image_url, label: "URL da imagem de capa"
    text_field :title, append: "max. 30", label: "Título"
    text_field :subtitle, append: "max. 600", label: "Subtítulo"
    select :profile_ids, Profile.all, { label: "Negócios" }, multiple: true
    date_field :expires_on, label: "Exibir até dia (padrão: sem limite)"
    row do
      col(sm: 6) { time_field :starts_at, label: "Começar a mostrar (horário)" }
      col(sm: 6) { time_field :finishes_at, label: "Parar de mostrar (horário)" }
    end
    row do
      col(sm: 6) { select :priority, List.priorities.keys.to_a }
      col(sm: 6) { select :status, List.statuses.keys.to_a }
    end
    if list.persisted?
      static_field :created_at
      static_field :updated_at
    end
  end
end
