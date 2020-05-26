module UxHelper

  def toast_success(toggle_id, message="")
    html=""
    html+="<!-- Toast success -->"
    html+="<div id='#{toggle_id}' class='toast-box toast-bottom bg-success'>"
    html+="  <div class='in'>"
    html+="    <ion-icon name='checkmark-circle' class='text-white'></ion-icon>"
    html+="    <div class='text text-white weight-5'>#{message}</div>"
    html+="  </div>"
    html+="  <button type='button' class='btn btn-sm btn-text-light close-button'>OK</button>"
    html+="</div>"
    html+="<!-- * Toast success -->"
    html.html_safe
  end

  def google_maps_link(address_line)
    "https://maps.google.com?daddr=#{address_line}, Ubatuba-SP"
  end

  def whatsapp_link(phone, text=nil)
    "https://wa.me/55#{phone}?lang=pt_br" + (text.present? ? "&text=#{text}" : "")
  end

end