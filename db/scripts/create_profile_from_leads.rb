# on rails console: load "db/scripts/create_profile_from_leads.rb"
# on heroku: heroku run bundle exec rails runner ./db/scripts/create_profile_from_leads.rb

LeadInstagram.all.each do |lead_insta|
  lead_excel = LeadExcel.find_by(instagram: lead_insta.username)

  # profile(com insta account) já não existe
  if !InstagramAccount.exists?(username: lead_insta.username)
    response = HTTParty.get("https://www.instagram.com/#{lead_insta.username}/?__a=1")
    bio = response["graphql"].present? ? response["graphql"]["user"]["biography"] : nil
    profile = Profile.create(username: lead_insta.username, avatar_url: lead_insta.avatar_url, title: lead_excel.present? ? lead_excel.name : lead_insta.title, tagline: lead_insta.title, bio: bio, whatsapp: lead_excel.present? ? lead_excel.whatsapp : nil, website: lead_excel.present? ? lead_excel.website : nil, status: 0)

    # address
    if lead_excel
      numero = lead_excel.numero ? lead_excel.numero.split("-").first.try(:strip) : nil
      complemento = lead_excel.numero ? lead_excel.numero.split("-").second.try(:strip) : nil
      bairro = Bairro.find_by_name(lead_excel.bairro)
      Address.create(profile: profile, logradouro: lead_excel.logradouro, numero: numero, complemento: complemento, bairro: bairro)
    end

    # instagram
    InstagramAccount.create(profile: profile, username: lead_insta.username, instagram_user_id: lead_insta.instagram_user_id)

    # delivery
    Delivery.create(profile: profile)
  end
end
