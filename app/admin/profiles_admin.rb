Trestle.resource(:profiles) do

  collection { Profile.order(id: :desc) }

  menu do
    item :profiles, icon: "fa fa-store", label: "Negócios"
  end

  search do |query|
    query ? Profile.where("title ILIKE ? OR tagline ILIKE ? OR username ILIKE ?","%#{query}%", "%#{query}%", "%#{query}%") : Profile.order(id: :desc)
  end

  scopes do
    scope :all, default: true, label: "Todos"
    scope :novo
    scope :aprovado
    scope :reivindicado
    scope :inativo
  end

  table do
    column :id, link: false
    column :avatar_url, header: false, align: :center, blank: nil do |profile|
      avatar(fallback: profile.initials) { image_tag(profile.avatar_url) }
    end
    column :title, header: "Negócio", link: false, sort: :title, class: "media-title-column" do |profile|
      safe_join([
        content_tag(:strong, profile.title),
        content_tag(:small, link_to(profile.username, profile.profile_path, target: "_blank", class: "external-link"), class: "text-muted hidden-xs")
      ], "<br />".html_safe)
    end
    column :sub_categ, sort: :sub_categ_id, link: false
    column :completion_progress, ->(profile) { status_tag(profile.completion_progress, :secondary) }, header: "%"
    column :whatsapp, header: "WhatsApp"
    column :name, ->(profile) { profile.address.present? ? profile.address.bairro : ""}, header: "Bairro", link: false
    column :username, ->(profile) { profile.instagram_account.present? ? link_to("@#{profile.instagram_account.username}", "https://www.instagram.com/#{profile.instagram_account.username}", target: "_blank", class: "external-link") : ""}, header: "Instagram", link: true
    column :status, align: :center do |profile|
      case profile.status.try(:to_sym)
      when :novo
        status_tag("novo", :warning)
      when :aprovado
        status_tag("aprovado", :info)
      when :reivindicado
        status_tag("reivindicado", :success)
      when :inativo
        status_tag("inativo", :danger)
      else
          status_tag("desconhecido", :secondary)
      end
    end
    column :created_at, ->(profile) { profile.created_at.strftime("%d/%m %H:%M")}, header: "Criado em", align: :center
    actions
  end

  form do |profile|
    tab :negócio do
      form_group :avatar_url, label: false, align: :left do
        link_to image_tag(profile.avatar_url), profile.avatar_url, data: { behavior: "zoom" }
      end if profile.avatar_url?
      select :status, Profile.statuses.keys.to_a
      select :sub_categ_id, SubCateg.all.order(:name), label: "Sub Categoria"
      text_field :username, append: "max. 30", label: "Username"
      text_field :title, append: "max. 30", label: "Título"
      text_field :tagline, append: "max. 60", label: "Tagline"
      text_area :bio, append: "max. 150"
      row do
        col(sm: 6) { telephone_field :whatsapp, prepend: status_tag(icon("fa fa-phone"), :success), label: "WhatsApp" }
        col(sm: 6) { telephone_field :phone_secondary, prepend: status_tag(icon("fa fa-phone"), :secondary), label: "Telefone 2" }
      end
      text_area :search_tags, append: "max. 150", label: "Termos de busca", placeholder: "Palavras-chave separadas por vírgula"
      number_field :employees_qty, label: "Quantas pessoas trabalham no negócio?"
      text_field :website
      text_field :avatar_url
      select :user_id, User.all.to_a.unshift(User.new)
      row do
        col(sm: 6) { static_field :created_at }
        col(sm: 6) { static_field :updated_at }
      end
    end

    tab :horários, badge: profile.opening_hours.count do
      table (OpeningHour.where("profile_id = ?", profile.id).order(:day)), admin: :opening_hour do
        column :day, ->(opening_hour) {link_to(opening_hour.day_to_s, trestle.opening_hours_admin_path(opening_hour.id))}, header: "Dia", link: true
        column :opens_at, ->(opening_hour) {"#{'%02d'%opening_hour.opens_at.hour}h às #{'%02d'%opening_hour.closes_at.hour}h"}, header: "Horário"
        column :id, ->(opening_hour) {link_to(status_tag(icon("fa fa-pencil")), trestle.opening_hours_admin_path(opening_hour.id))}, link: true, header: ""
      end

      if profile.opening_hours.count < 7
        concat "</br>".html_safe
        concat admin_link_to("Novo horário", admin: :opening_hours, action: :new, params: { profile_id: profile }, class: "btn btn-success")
      end
    end

    tab :endereço, badge: profile.address.present? ? 1 : nil do
      table (Address.where("profile_id = ?", profile.id)), admin: :address do
        column :logradouro, ->(address) {link_to(address.logradouro, trestle.addresses_admin_path(address.id))}, link: true
        column :numero
        column :complemento
        column :bairro
      end

      if profile.address && profile.address.persisted?
        concat "</br>".html_safe
        concat link_to(icon("fa fa-pencil")+" Editar", trestle.addresses_admin_path(profile.address.id), class: "btn btn-success")
      else
        concat "</br>".html_safe
        concat admin_link_to("Novo Endereço", admin: :addresses, action: :new, params: { profile_id: profile }, class: "btn btn-success")
      end
    end

    tab :instagram, badge: profile.instagram_account.present? ? 1 : nil do
      table (InstagramAccount.where("profile_id = ?", profile.id)), admin: :instagram_account do
        column :avatar_url, header: false, align: :center, blank: nil do |instagram_account|
          lead = LeadInstagram.find_by_username(instagram_account.username)
          avatar(fallback: profile.initials) { lead ? image_tag(lead.avatar_url) : nil }
        end
        column :username, ->(instagram_account) {link_to(instagram_account.username, trestle.instagram_accounts_admin_path(instagram_account.id))}, link: true
        column :access_token
        column :instagram_user_id
        column :created_at, header: "Criado em", align: :center
        column :id, ->(instagram_account) {link_to(status_tag(icon("fa fa-pencil")), trestle.instagram_accounts_admin_path(instagram_account.id))}, link: true, header: ""
      end

      if profile.instagram_account.blank?
        concat "</br>".html_safe
        concat admin_link_to("Novo Instagram", admin: :instagram_accounts, action: :new, params: { profile_id: profile }, class: "btn btn-success")
      end

    end

  end

end
