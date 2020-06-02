module MasksHelper

  def mask_money(amount, unit="R$ ")
    number_to_currency(amount/100.00, unit: unit, separator: ",", delimiter: "")
  end

  def mask_phone(phone)
    "(#{phone[0,2]}) #{phone[2, (phone.length-6)]}-#{phone[-4,4]}"
  end

  def mask_url(url)
    (url[/\Ahttp:\/\//] || url[/\Ahttps:\/\//]) ? url : "http://#{url}"
  end

  def add_breaklines(text)
    if text.present?
      text.split("\n").join("<br/>").html_safe
    else
      ""
    end
  end

  def remove_emojis(text)
    clean = ""
    if text.present?
      text = text.force_encoding('utf-8').encode

      # symbols & pics
      regex = /[\u{1f300}-\u{1f5ff}]/
      clean = text.gsub regex, " "
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
    clean
  end
end