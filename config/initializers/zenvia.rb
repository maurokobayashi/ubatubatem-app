require 'zenvia'

Zenvia.configure do |config|
  config.account  = ENV['ZENVIA_ACCOUNT']
  config.code     = ENV['ZENVIA_CODE']
  config.from     = 'ubatubatem.com'
  # config.callbackOption = 'NONE'
end