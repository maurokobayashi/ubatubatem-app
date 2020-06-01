# on rails console: load "db/scripts/create_bairros_and_addresses.rb"
# on heroku: heroku run bundle exec rails runner ./db/scripts/create_profile_from_leads.rb
if Bairro.all.blank?
  Bairro.create!([
    {name: "Itaguá", lat: -23.4549484, lng: -45.0754529, regiao: "centro"},
    {name: "Estufa I", lat: -23.4483411, lng: -45.0961145, regiao: "centro"},
    {name: "Estufa II", lat: -23.4538167, lng: -45.0857998, regiao: "centro"},
    {name: "Centro", lat: -23.4358973, lng: -45.0834438, regiao: "centro"},
    {name: "Umuarama (Centro)", lat: -23.4373594, lng: -45.0904114, regiao: "centro"},
    {name: "Silop (Centro)", lat: -23.4378956, lng: -45.088693, regiao: "centro"},
    {name: "Jardim Carolina", lat: -23.4382016, lng: -45.1007926, regiao: "centro"},
    {name: "Marafunda", lat: -23.4361867, lng: -45.1115513, regiao: "centro"},
    {name: "Ressaca", lat: -23.43099, lng: -45.093326, regiao: "centro"},
    {name: "Ipiranguinha", lat: -23.4272405, lng: -45.1254705, regiao: "serra"},
    {name: "Horto", lat: -23.4181255, lng: -45.1259037, regiao: "serra"},
    {name: "Figueira", lat: -23.3973141, lng: -45.1383287, regiao: "serra"},
    {name: "Sesmaria", lat: -23.4658114, lng: -45.095852, regiao: "serra"},
    {name: "Perequê Açu", lat: -23.4204397, lng: -45.0748701, regiao: "norte"},
    {name: "Sumidouro", lat: -23.4110539, lng: -45.0733212, regiao: "norte"},
    {name: "Taquaral", lat: -23.4019155, lng: -45.0767058, regiao: "norte"},
    {name: "Barra Seca", lat: -23.4188967, lng: -45.0528719, regiao: "norte"},
    {name: "Itamambuca", lat: -23.4025298, lng: -45.018162, regiao: "norte"},
    {name: "Félix", lat: -23.3917583, lng: -44.9814515, regiao: "norte"},
    {name: "Prumirim", lat: -23.3774283, lng: -44.969543, regiao: "norte"},
    {name: "Puruba", lat: -23.3434844, lng: -44.9468121, regiao: "norte"},
    {name: "Ubatumirim", lat: -23.3373699, lng: -44.9160083, regiao: "norte"},
    {name: "Ubatumirim (Sertão)", lat: -23.3051518, lng: -44.8706138, regiao: "norte"},
    {name: "Almada", lat: -23.3592769, lng: -44.889551, regiao: "norte"},
    {name: "Fazenda (Praia)", lat: -23.3776971, lng: -44.8557892, regiao: "norte"},
    {name: "Camburi", lat: -23.3686814, lng: -44.8099711, regiao: "norte"},
    {name: "Tenório", lat: -23.4609125, lng: -45.0699523, regiao: "centro"},
    {name: "Vermelha do Centro", lat: -23.4616605, lng: -45.0598242, regiao: "centro"},
    {name: "Praia Grande", lat: -23.4700892, lng: -45.0770014, regiao: "sul"},
    {name: "Toninhas", lat: -23.4955835, lng: -45.0901383, regiao: "sul"},
    {name: "Enseada", lat: -23.4918765, lng: -45.0910537, regiao: "sul"},
    {name: "Perequê Mirim", lat: -23.4889623, lng: -45.1169509, regiao: "sul"},
    {name: "Saco da Ribeira", lat: -23.5033937, lng: -45.1321095, regiao: "sul"},
    {name: "Lázaro", lat: -23.502764, lng: -45.1390618, regiao: "sul"},
    {name: "Domingas Dias (Lázaro)", lat: -23.5008356, lng: -45.1441902, regiao: "sul"},
    {name: "Rio Escuro", lat: -23.4806348, lng: -45.1646286, regiao: "sul"},
    {name: "Folha Seca", lat: -23.4792042, lng: -45.183909, regiao: "sul"},
    {name: "Corcovado", lat: -23.481324, lng: -45.1929208, regiao: "sul"},
    {name: "Praia Vermelha do Sul", lat: -23.5102323, lng: -45.1809228, regiao: "sul"},
    {name: "Praia da Fortaleza", lat: -23.5295881, lng: -45.1763013, regiao: "sul"},
    {name: "Lagoinha", lat: -23.5184064, lng: -45.2161479, regiao: "sul"},
    {name: "Sapê", lat: -23.5273361, lng: -45.2349808, regiao: "sul"},
    {name: "Maranduba", lat: -23.5423433, lng: -45.2418902, regiao: "sul"},
    {name: "Sertão da Quina", lat: -23.5313454, lng: -45.2560564, regiao: "sul"},
    {name: "Jardim Samambaia", lat: -23.4377613, lng: -45.09783, regiao: "centro"}
  ])
end

LeadExcel.all.each do |lead_excel|
  profile = Profile.find_by(username: lead_excel.instagram)
  if profile
    # address
    numero = lead_excel.numero ? lead_excel.numero.split("-").first.try(:strip) : nil
    complemento = lead_excel.numero ? lead_excel.numero.split("-").second.try(:strip) : nil
    bairro = Bairro.find_by_name(lead_excel.bairro)
    Address.create(profile: profile, logradouro: lead_excel.logradouro, numero: numero, complemento: complemento, bairro: bairro)
  end
end
