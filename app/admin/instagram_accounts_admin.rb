Trestle.resource(:instagram_accounts) do
  build_instance do |attrs, params|
    attrs[:profile] = Profile.find(params[:profile_id]) if params[:profile_id]
    InstagramAccount.new(attrs)
  end

  menu do
    item :accounts, icon: "fa fa-instagram", label: "Instagram Accounts", group: "dados da conta"
  end

  search do |query|
    query ? InstagramAccount.where("username ILIKE ?","%#{query}%") : InstagramAccount.all
  end

end
