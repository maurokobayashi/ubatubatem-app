# on rails console: load "db/scripts/create_profile_from_leads.rb"
# on heroku: heroku run bundle exec rails runner ./db/scripts/create_profile_from_leads.rb

LeadInstagram.where("id > 927").each do |lead_insta|
  if !InstagramAccount.exists?(username: lead_insta.username)
    response = HTTParty.get("https://www.instagram.com/#{lead_insta.username}/?__a=1")
    # bio = response["graphql"].present? ? response["graphql"]["user"]["biography"] : nil
    title = lead_insta.title.present? ? lead_insta.title : lead_insta.username
    profile = Profile.create(username: lead_insta.username, avatar_url: lead_insta.avatar_url, title: title, tagline: title, status: 0)
    puts profile.inspect
    InstagramAccount.create(profile: profile, username: lead_insta.username, instagram_user_id: lead_insta.instagram_user_id)
  end
end
