# on rails console: load "db/scripts/create_profile_from_leads.rb"

LeadExcel.all.each do |lead_excel|
  lead_insta = LeadInstagram.find_by_username lead_excel.instagram
  # tem lead insta e profile(com insta account) já não existe
  if lead_insta.present? && !InstagramAccount.exists?(username: lead_excel.instagram)
    profile = Profile.create(title: lead_excel.name, tagline: lead_insta.title, bio: nil, whatsapp: lead_excel.whatsapp, website: lead_excel.website, status: 0)

    # address
    numero = lead_excel.numero ? lead_excel.numero.split("-").first.try(:strip) : nil
    complemento = lead_excel.numero ? lead_excel.numero.split("-").second.try(:strip) : nil
    address = Address.create(profile: profile, logradouro: lead_excel.logradouro, numero: numero, complemento: complemento, bairro: Bairro.find_by_name(lead_excel.bairro))
    # instagram
    InstagramAccount.create(profile: profile, username: lead_insta.username)
    # delivery
    Delivery.create(profile: profile)
  end
end