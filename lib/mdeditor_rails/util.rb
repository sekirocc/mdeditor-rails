# encoding: utf-8
require 'active_support/json/encoding'

module MdeditorRails
  module Util
    class << self
      ASSET_FORMAT = '*.{coffee,scss,sass,png,jpeg,jpg,gif,js,css,erb}'
      NEED_TO_COMPILE_STYLESHEET_EXT = %w(.scss .sass .coffee .erb)

      def html_tag(view_helper, &block)
        h = view_helper.content_tag(:div, 
          view_helper.content_tag(:div, 
            view_helper.content_tag(:div, '', :id => 'wmd-button-bar') +
            view_helper.content_tag(:div, yield , :class => 'wmd-panel wmd-panel-for-input') + 
            view_helper.content_tag(:div, 
              view_helper.content_tag(:div, '', :id => 'wmd-preview'), 
              :class => 'wmd-panel '), 
            :class => 'wmd-wrapper'),
          :class => 'editor')

        h.html_safe
      end

      def js_code
        js = <<-JS
          $(function() {
            MdeditorRails.startEdit()
            $(".switch").not(".has-switch")["bootstrapSwitch"]()
          })
        JS
        js.html_safe
      end

      def precompile_assets
        assets = []

        %w(app vendor).each do |source|
          %w(images javascripts stylesheets).each do |kind|
            Dir[MdeditorRails.root_path.join("#{source}/assets/#{kind}/**", ASSET_FORMAT)].each do |path|
              next if File.basename(path)[0] == '_'

              ext = File.extname(path)
              path = path[0..-ext.length-1] if NEED_TO_COMPILE_STYLESHEET_EXT.include? ext

              assets << Pathname.new(path).relative_path_from(MdeditorRails.root_path.join("#{source}/assets/#{kind}"))
            end
          end
        end

        assets
      end

    end
  end
end
