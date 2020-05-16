Trestle.resource(:profiles) do
  menu do
    group :catálogo do
      item :profiles, icon: "fa fa-store", label: "Negócios"
    end
  end

  search do |query|
    query ? Profile.where("title ILIKE ? OR tagline ILIKE ? OR whatsapp ILIKE ?","%#{query}%", "%#{query}%", "%#{query}%") : Profile.all
  end

  scopes do
    scope :all, default: true, label: "Todos"
    scope :novo
    scope :ativo
    scope :denunciado
    scope :inativo
  end

  table do
    column :id, link: true
    column :username, ->(profile) { profile.user.username }, link: true
    column :title, header: "Negócio", link: true, sort: :title, class: "media-title-column" do |profile|
      safe_join([
        content_tag(:strong, profile.title),
        content_tag(:small, profile.tagline, class: "text-muted hidden-xs")
      ], "<br />".html_safe)
    end
    column :whatsapp, header: "WhatsApp"
    column :status, align: :center do |profile|
      case profile.status.to_sym
      when :novo
        status_tag(icon("fa fa-question")+" novo", :info)
      when :ativo
        status_tag(icon("fa fa-check")+" ativo", :success)
      when :denunciado
        status_tag(icon("fa fa-exclamation-triangle"+" denunciado"), :warning)
      when :inativo
        status_tag(icon("fa fa-times")+" inativo", :danger)
      end
    end
    column :created_at, header: "Criado em", align: :center
    actions
  end

  form do
    tab :profile do
      select :user, User.all
      select :status, Profile.statuses
      text_field :title, append: "max. 30"
      text_field :tagline, append: "max. 60"
      text_area :bio, append: "max. 255"
      row do
        col(sm: 6) { text_field :whatsapp, prepend: status_tag(icon("fa fa-phone"), :success) }
        col(sm: 6) { text_field :phone_secondary, prepend: status_tag(icon("fa fa-phone"), :secondary) }
      end
      row do
        col(sm: 6) { datetime_field :created_at }
        col(sm: 6) { datetime_field :updated_at }
      end
    end

    tab :photos do
    end

  end

end
