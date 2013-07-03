require 'rails'
require 'mdeditor_rails'

module MdeditorRails
  class Engine < ::Rails::Engine
    isolate_namespace MdeditorRails


    initializer "mdeditor.assets_precompile", group: :all do |app|
      app.config.assets.precompile += MdeditorRails.assets
    end

    initializer "mdeditor.helpers" do
      ActiveSupport.on_load :action_view do
        ActionView::Base.send :include, MdeditorRails::Helpers::ViewHelper
      end
    end

  end
end
