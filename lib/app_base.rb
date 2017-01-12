require "app_base/version"
_root_ = File.expand_path('../../', __FILE__)

module AppBase
  class Engine < Rails::Engine
    config.autoload_paths << "#{ config.root }/app/controllers/concerns/"
    config.autoload_paths << "#{ config.root }/app/models/concerns/"

    initializer :add_base_paths do
      ActiveSupport.on_load(:active_record) do
        _root_ = ::AppBase::Engine.config.root
        ::Rails.application.config.paths['db/migrate'] << "#{ _root_ }/db/migrate"
      end

      ActiveSupport.on_load(:action_controller) do
        _root_  = ::AppBase::Engine.config.root
        views = "app/views/app_base"
        prepend_view_path("#{ _root_ }/#{ views }" ) if respond_to?(:prepend_view_path)
      end
    end
  end
end

require "#{ _root_ }/config/routes"
