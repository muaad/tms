# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( fontawesome-webfont.eot )
Rails.application.config.assets.precompile += %w( fontawesome-webfont.woff )
Rails.application.config.assets.precompile += %w( fontawesome-webfont.ttf )
Rails.application.config.assets.precompile += %w( fontawesome-webfont.svg )

# Add additional assets to the asset load path
Rails.application.config.assets.paths << File.join(Rails.root, 'vendor/assets')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.configuration.assets.precompile += %w[serviceworker.js manifest.json]
