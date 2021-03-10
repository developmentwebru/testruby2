Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  SiteConfig =
    case ENV["ANYWAY_CONFIG_NAME"]
    when "els" then ElsConfig
    else ElsConfig
    end

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true


  # Raises error for missing translations.
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Add rails to allowed hosts to allow docker-compose && docker swarm to access app
  config.hosts << "rails"

  # Docker web-console silence
  # (Cannot render console from a.b.c.d! Allowed networks: 127.0.0.0/127.255.255.255, ::1)
  config.web_console.whiny_requests = false

  # Mailer settings + letter_opener
  config.action_mailer.default_url_options = { host: SiteConfig.domain, port: 3000 }
  config.action_mailer.delivery_method = :letter_opener_web
  config.action_mailer.perform_deliveries = true
end
