Trestle.resource(:claims) do
  menu do
    item :claims, icon: "fas fa-envelope-open-text", label: "Reivindicações"
  end

  scopes do
    scope :all, default: true, label: "Todos"
    scope :solicitado
    scope :usado
  end

  table do
    column :profile, ->(claim) {link_to(claim.profile.title, claim.profile.profile_path, target: "_blank")}, header: "Negócio"
    column :instagram, ->(claim) { claim.profile.instagram_account.present? ? link_to(claim.profile.instagram_account.username, "https://www.instagram.com/#{claim.profile.instagram_account.username}", target: "_blank", class: "external-link") : "Não cadastrado"}, header: "Instagram", link: true
    column :user, ->(claim) {claim.user.try(:email)}, header: "Solicitado por"
    column :uuid, ->(claim) {claim.confirmation_link}, header: "Link de confirmação"
    column :status, ->(claim) {status_tag(claim.status, :info)}
    column :created_at, header: "Criado em", align: :center
    actions
  end

  form do |claim|
    select :profile_id, Profile.all.to_a.unshift(Profile.new), label: "Negócio"
    select :user_id, User.all.to_a.unshift(User.new), label: "Solicitado por"
    select :status, Claim.statuses.keys.to_a
    text_field :uuid, label: "Código (link) - ubatubatem.com/reivindicar/xxxx"
    datetime_field :created_at, label: "Criado em"

  end

end
