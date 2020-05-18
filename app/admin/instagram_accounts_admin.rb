Trestle.resource(:instagram_accounts) do
  menu do
    item :accounts, icon: "fa fa-instagram", label: "Instagram Accounts", group: "dados cadastrados"
  end

  search do |query|
    query ? InstagramAccount.where("username ILIKE ?","%#{query}%") : InstagramAccount.all
  end

end
