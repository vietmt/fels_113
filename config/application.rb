require File.expand_path('../boot', __FILE__)
require 'rails/all'
Bundler.require(*Rails.groups)
module BaseApp
  class Application < Rails::Application
    config.action_view.embed_authenticity_token_in_remote_forms = true
    config.active_record.raise_in_transactional_callbacks = true
  end
end
