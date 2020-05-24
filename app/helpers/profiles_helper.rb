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

  def mask_phone(phone)
    "(#{phone[0,2]}) #{phone[2, (phone.length-6)]}-#{phone[-4,4]}"
  end

end
