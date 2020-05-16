Trestle.resource(:profiles) do
  menu do
    item :profiles, icon: "fa fa-store", label: "Negócios"
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
    column :title, header: "Negócio", link: true, sort: :title, class: "media-title-column" do |profile|
      safe_join([
        content_tag(:strong, profile.title),
        content_tag(:small, profile.tagline, class: "text-muted hidden-xs")
      ], "<br />".html_safe)
    end
    column :username, ->(profile) { profile.instagram_account.present? ? link_to("@#{profile.instagram_account.username}", "https://www.instagram.com/#{profile.instagram_account.username}", target: "_blank", class: "external-link") : ""}, header: "Instagram", link: true
    column :whatsapp, header: "WhatsApp"
    column :status, align: :center do |profile|
      case profile.status.try(:to_sym)
      when :novo
        status_tag("novo", :info)
      when :ativo
        status_tag(icon("fa fa-check")+" ativo", :success)
      when :denunciado
        status_tag(icon("fa fa-exclamation-triangle"+" denunciado"), :warning)
      when :inativo
        status_tag(icon("fa fa-times")+" inativo", :danger)
      else
          status_tag("desconhecido", :secondary)
      end
    end
    column :created_at, header: "Criado em", align: :center
    actions
  end

  form do |profile|
    tab :negócio do
      select :status, Profile.statuses.keys.to_a
      text_field :title, append: "max. 30"
      text_field :tagline, append: "max. 60"
      text_area :bio, append: "max. 255"
      row do
        col(sm: 6) { telephone_field :whatsapp, prepend: status_tag(icon("fa fa-phone"), :success) }
        col(sm: 6) { telephone_field :phone_secondary, prepend: status_tag(icon("fa fa-phone"), :secondary) }
      end
      row do
        col(sm: 6) { static_field :created_at }
        col(sm: 6) { static_field :updated_at }
      end
    end

    tab :endereço do
      table (Address.where("profile_id = ?", profile.id)), admin: :address do
        column :logradouro, ->(address) { address.present? ? link_to(address.logradouro, trestle.addresses_admin_path(address.id)) : ""}, link: true
        column :numero
        column :complemento
        column :bairro
        column :id, ->(address) { address.present? ? link_to(status_tag(icon("fa fa-pencil")), trestle.addresses_admin_path(address.id)) : ""}, link: true, header: ""
      end
    end

    tab :instagram do
      table (InstagramAccount.where("profile_id = ?", profile.id)), admin: :instagram_account do
        column :username, ->(instagram_account) { instagram_account.present? ? link_to(instagram_account.username, trestle.instagram_accounts_admin_path(instagram_account.id)) : ""}, link: true
        column :access_token
        column :instagram_user_id
        column :created_at, header: "Criado em", align: :center
        column :id, ->(instagram_account) { instagram_account.present? ? link_to(status_tag(icon("fa fa-pencil")), trestle.instagram_accounts_admin_path(instagram_account.id)) : ""}, link: true, header: ""
      end
    end

  end

end
