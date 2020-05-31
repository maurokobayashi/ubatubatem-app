class Cookies
  # usecases:
  # cookies[Cookies::REMEMBER_TOKEN[:name]] = { value: "lorenipsum", expires: Cookies::REMEMBER_TOKEN[:expires] }

  REMEMBER_TOKEN = {name: :remember_token, expires: 1.year.from_now}

end