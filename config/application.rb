require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ubatubatem
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    config.time_zone = 'America/Sao_Paulo'

  end
end
