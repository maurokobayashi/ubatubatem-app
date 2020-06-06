Profile.all.each do |p|
  if p.bio.present?
    clean = p.bio
    clean = clean.force_encoding('utf-8').encode
    clean = clean.gsub /[\u{1f300}-\u{1f5ff}]/, ""
    clean = clean.gsub /[\u{2500}-\u{2BEF}]/, ""
    clean = clean.gsub /[\u{1f600}-\u{1f64f}]/, ""
    clean = clean.gsub /[\u{2702}-\u{27b0}]/, ""
    p.bio = clean.strip
    p.save
  end
end