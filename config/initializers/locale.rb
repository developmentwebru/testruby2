# Whitelist locales available for the application
I18n.available_locales = [:ru, :en]

# Set default locale to something other than :en
I18n.default_locale = :ru

# Load locales in nested folders
I18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}")]