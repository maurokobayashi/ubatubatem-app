module ProfilesHelper

  def humanize_delivery_mode(delivery)
    delivery_modes = []
    if delivery.present?
      delivery_modes.push "Delivery" if delivery.has_delivery?
      delivery_modes.push "Retirada" if delivery.has_retirada?
    end
    delivery_modes.join " ou "
  end

  def humanize_address(address)
    address_line=""
    address_line+=address.logradouro if address.logradouro.present?
    address_line+=", #{address.numero}" if address.numero.present?
    address_line+=" (#{address.complemento})" if address.complemento.present?
    address_line+=" - #{address.bairro.name}" if address.bairro.present?
  end

  def humanize_opening_hours(profile)
    text = ""
    current_opening_day = @profile.current_opening_day
    opens_today = current_opening_day.present?
    opened_now = profile.open?

    if opens_today
      opens_at = current_opening_day.opens_at.strftime("%Hh%M").delete_prefix("0").delete_suffix("00")
      closes_at = current_opening_day.closes_at.strftime("%Hh%M").delete_prefix("0").delete_suffix("00")
      if opened_now
        text+="<span class=\"text-success\">Aberto agora</span>"
      else
        not_open_yet = current_opening_day.opens_at.hour >= DateTime.now.hour
        text+= not_open_yet ? "Abre hoje" : "Fechado"
      end
      text+=" - #{opens_at} às #{closes_at}"
    else
      text+="Fechado hoje"
    end
    text.html_safe
  end

  def verified_badge_for(profile)
    "<ion-icon name=\"checkmark-circle\" class=\"text-primary\"></ion-icon>".html_safe if profile.reivindicado?
  end

end
