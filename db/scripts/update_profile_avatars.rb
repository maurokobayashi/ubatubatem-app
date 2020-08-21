# on rails console: load "db/scripts/update_profile_avatars.rb"
# on heroku: heroku run bundle exec rails runner ./db/scripts/update_profile_avatars.rb

# ATENÇÃO! ESSE SCRIPT DEVE SER EXECUTADO EM LOCALHOST, POIS O INSTAGRAM BLOQUEOU REQUISIÇÕES A PARTIR DO SERVIDOR DO HEROKU

profiles_response = HTTParty.get("https://www.ubatubatem.app/profiles.json?limit=100&offset=860")
profiles = JSON(profiles_response.body)
profiles.each do |p|
  puts "Fazendo SCRAPPING do perfil #{p['username']} no Instagram..."
  instagram_response = HTTParty.get("https://www.instagram.com/#{p['username']}/?__a=1")
  avatar_url = instagram_response["graphql"].present? ? instagram_response["graphql"]["user"]["profile_pic_url"] : nil

  puts "Atualizando avatar do perfil ID #{p['id']} no ubatubatem.app..."
  data = {profile: {avatar_url: avatar_url}}
  update_response = HTTParty.patch("https://www.ubatubatem.app/profiles/#{p['id']}/avatar", :body => data)
  puts "HTTP Status: #{update_response.code}\n\n"
end



