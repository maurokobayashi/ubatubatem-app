module MasksHelper

  def mask_money(amount, unit="R$ ")
    number_to_currency(amount/100.00, unit: unit, separator: ",", delimiter: "")
  end

  def mask_phone(phone)
    "(#{phone[0,2]}) #{phone[2, (phone.length-6)]}-#{phone[-4,4]}"
  end

  def mask_url(url)
    (url[/\Ahttp:\/\//] || url[/\Ahttps:\/\//]) ? hrl : "http://#{url}"
  end
end