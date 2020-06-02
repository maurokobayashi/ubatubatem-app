Profile.all.each do |profile|
  if profile.bio.present?
    puts "p = Profile.find_by(username: \"#{profile.username}\")"
    puts "p.update_attribute(:bio, \"#{profile.bio}\")"
  end
end; nil