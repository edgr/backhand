require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Backhand
  class Application < Rails::Application
    config.generators do |generate|
          generate.assets false
          generate.helper false
          generate.test_framework  :test_unit, fixture: false
        end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    #use customize error pages
    config.exceptions_app = self.routes

    #default locale for i18n setup
    config.i18n.default_locale = :en

    #specifying background job service
    config.active_job.queue_adapter = :sidekiq

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

Raven.configure do |config|
  config.dsn = 'https://ad0d285d9a0548c3af5d56ca1b405a93:5fe34898083e43b0ad63632c7571e435@sentry.io/1767983'
end

