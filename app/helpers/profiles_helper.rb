module ProfilesHelper

  def humanize_delivery_mode(delivery)
    delivery_modes = []
    if delivery.present?
      delivery_modes.push "Delivery" if delivery.has_delivery?
      delivery_modes.push "Retirada" if delivery.has_retirada?
    end
    delivery_modes.join " ou "
  end
end
