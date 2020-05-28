module UxHelper

  def toast_notification(toggle_id, color="primary", message="")
    html=""
    html+="<!-- Toast notification -->"
    html+="<div id='#{toggle_id}' class='toast-box toast-bottom bg-#{color}'>"
    html+="  <div class='in'>"
    html+="    <ion-icon name='checkmark-circle' class='text-white'></ion-icon>"
    html+="    <div class='text text-white weight-5'>#{message}</div>"
    html+="  </div>"
    html+="  <button type='button' class='btn btn-sm btn-text-light close-button'>OK</button>"
    html+="</div>"
    html+="<!-- * Toast notification -->"
    html.html_safe
  end

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