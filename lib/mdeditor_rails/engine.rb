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
        ActionView::Base.send :include, MdeditorRails::Helpers::FormHelper
        ActionView::Helpers::FormBuilder.send :include, MdeditorRails::Helpers::FormBuilder
      end
    end

    initializer "mdeditor.hooks" do
      if Object.const_defined?("SimpleForm")
        require "mdeditor_rails/hooks/simple_form"
      end
    end

  end
end
