Trestle.resource(:lead_instagrams) do
  menu do
    item :lead_instagrams, icon: "fa fa-instagram", label: "Instagram Following", group: "configurações"
  end

  search do |query|
    query ? LeadInstagram.where("username ILIKE ? OR title ILIKE ?", "%#{query}%", "%#{query}%") : LeadInstagram.all
  end

  table do
    column :avatar_url, header: false, align: :center, blank: nil do |lead_instagram|
      avatar(fallback: "?") { image_tag(lead_instagram.avatar_url) }
    end
    column :username, link: true, sort: :username, header: "Perfil", class: "media-title-column" do |lead_instagram|
      safe_join([
        content_tag(:strong, lead_instagram.username),
        content_tag(:small, lead_instagram.title, class: "text-muted hidden-xs")
      ], "<br />".html_safe)
    end
    column :instagram_user_id, header: "Instagram User Id"
    column :created_at, align: :center, header: "Criado em"
    actions
  end

end
