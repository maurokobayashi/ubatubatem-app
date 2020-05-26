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

  def remove_emojis(text)
    text = text.force_encoding('utf-8').encode
    clean = ""

    # symbols & pics
    regex = /[\u{1f300}-\u{1f5ff}]/
    clean = text.gsub regex, ""

    # enclosed chars
    regex = /[\u{2500}-\u{2BEF}]/ # I changed this to exclude chinese char
    clean = clean.gsub regex, ""

    # emoticons
    regex = /[\u{1f600}-\u{1f64f}]/
    clean = clean.gsub regex, ""

    #dingbats
    regex = /[\u{2702}-\u{27b0}]/
    clean = clean.gsub regex, ""
  end
end