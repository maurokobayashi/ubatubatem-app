Trestle.resource(:instagram_accounts) do
  menu do
    group :catálogo do
      item :accounts, icon: "fa fa-instagram", label: "Instagram Accounts"
    end
  end

  search do |query|
    query ? InstagramAccount.where("username ILIKE ?","%#{query}%") : InstagramAccount.all
  end

end
