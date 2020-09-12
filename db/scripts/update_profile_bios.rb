# on rails console: load "db/scripts/update_profile_bios.rb"
# on heroku: heroku run bundle exec rails runner ./db/scripts/update_profile_bios.rb

# ATENÇÃO! ESSE SCRIPT DEVE SER EXECUTADO EM LOCALHOST, POIS O INSTAGRAM BLOQUEOU REQUISIÇÕES A PARTIR DO SERVIDOR DO HEROKU

profiles_response = HTTParty.get("https://www.ubatubatem.com/profiles.json?limit=900&offset=100")
profiles = JSON(profiles_response.body)
profiles.each do |p|
  if p['bio'].blank?
    puts "Fazendo SCRAPPING do perfil #{p['username']} no Instagram..."
    instagram_response = HTTParty.get("https://www.instagram.com/#{p['username']}/?__a=1")
    bio = instagram_response["graphql"].present? ? instagram_response["graphql"]["user"]["biography"] : nil
    puts "Atualizando bio do perfil ID #{p['id']} no ubatubatem.com..."
    data = {profile: {bio: bio}}
    update_response = HTTParty.patch("https://www.ubatubatem.com/profiles/#{p['id']}/bio", :body => data)
    puts "HTTP Status: #{update_response.code}\n\n"
  else
    puts "Bio já existe. Pulando...\n\n"
  end

end



