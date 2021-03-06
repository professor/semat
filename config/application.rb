require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module SEMAT
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    #config.autoload_paths += Dir["#{config.root}/app/services/**/"]

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Todd Sedano added
    # Source: http://stackoverflow.com/questions/19840540/bootstrap-glyphicons-error-404-in-production
    # Removes  ActionController::RoutingError (No route matches [GET] "/assets/twitter/glyphicons-halflings-regular.svg"):
    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    # Todd Sedano added
    # Source: http://mrdanadams.com/2011/exclude-active-admin-js-css-rails/#.Uo_kqmRgZ3Y
    # Allows active admin to be pre-compiled
   config.assets.precompile += %w[admin/active_admin.css admin/active_admin.js]

  end
end
