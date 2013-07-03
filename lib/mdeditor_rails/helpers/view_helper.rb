module MdeditorRails
  module Helpers
    module ViewHelper
      extend ActiveSupport::Concern
      
      def mdtext_area_tag(name, content = nil, options = {})
        element_id = 'wmd-input'
        element_class = 'wmd-input'
        options = { :language => I18n.locale.to_s }.merge(options)
        input_html = ( options.delete(:input_html) || {} ).merge({ :id => element_id, :class => element_class })
        js_content_for_section = options.delete(:js_content_for)
        
        output_buffer = ActiveSupport::SafeBuffer.new

        editor_div = content_tag(:div, 
          content_tag(:div, 
            content_tag(:div, '', :id => 'wmd-button-bar') +
            content_tag(:div, 
              text_area_tag(name, content, input_html), 
              :class => 'wmd-panel wmd-panel-for-input') + 
            content_tag(:div, 
              content_tag(:div, '', :id => 'wmd-preview'), 
              :class => 'wmd-panel '), 
            :class => 'wmd-wrapper'),
          :class => 'editor')

        output_buffer << editor_div

        
        # js = Utils.js_replace(element_id, options)
        
        # output_buffer << (js_content_for_section ? content_for(js_content_for_section, js) : javascript_tag(js))
        output_buffer
      end
    end
  end
end
