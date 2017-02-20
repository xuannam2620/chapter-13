require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SampleApp2
  class Application < Rails::Application
    config.middleware.use SimplesIdeias::I18n::Middleware
    config.assets.initialize_on_precompile = true
  end
end
