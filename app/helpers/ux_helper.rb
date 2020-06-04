module UxHelper

  def progress_bar(percentual, label=nil, colored=false, clazz="")
    bar_color = ""
    if colored
      bar_color = "bg-success" if percentual >= 80
      bar_color = "bg-primary" if percentual.between? 30, 79
      bar_color = "bg-danger" if percentual.between? 0, 29
    end

    percentual = percentual.to_s
    html=""
    html+="<small>"+label+"</small>" if label.present?
    html+="<div class='mt-1 progress #{clazz}'>"
    html+="  <div class='progress-bar #{bar_color}' role='progressbar' style='width: #{percentual}%;' aria-valuenow='#{percentual}' aria-valuemin='0' aria-valuemax='100'>"
    html+="    "+percentual+"%"
    html+="  </div>"
    html+="</div>"
    html.html_safe
  end

  # Links
  def google_maps_link(address_line)
    "https://maps.google.com?daddr=#{address_line}, Ubatuba-SP"
  end

  def whatsapp_link(phone, text=nil)
    "https://wa.me/55#{phone}?lang=pt_br" + (text.present? ? "&text=#{text}" : "")
  end

  # Social Share Links
  def share_whatsapp_link(link=root_url)
    link+="?utm_source=whatsapp&utm_medium=social&utm_campaign=link_share"
    "https://api.whatsapp.com/send?text=#{link.force_encoding('UTF-8')}"
  end

  def share_facebook_link(link=root_url)
    link+="?utm_source=facebook&utm_medium=social&utm_campaign=link_share"
    "https://www.facebook.com/sharer/sharer.php?u=#{link}"
  end

  def share_twitter_link(link=root_url, text="Pequenos Negócios em Ubatuba")
    link+="?utm_source=twitter&utm_medium=social&utm_campaign=link_share"
    "https://twitter.com/share?url=#{link}&text=#{text}"
  end

end