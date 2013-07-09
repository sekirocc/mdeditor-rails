module MdeditorRails
  module Helpers
    module ViewHelper
      extend ActiveSupport::Concern
      
      def mdtext_area_tag(name, content = nil, options = {})
        element_id = 'wmd-input'
        element_class = 'wmd-input'
        options = { :language => I18n.locale.to_s }.merge(options)
        input_html = options.merge({ :id => element_id, :class => element_class })
        js_content_for_section = options.delete(:js_content_for)
        
        output_buffer = ActiveSupport::SafeBuffer.new
        output_buffer << Util.html_tag(self) { text_area_tag(name, content, input_html) }
        js = Util.js_code
        output_buffer << (js_content_for_section ? content_for(js_content_for_section, javascript_tag(js)) : javascript_tag(js))
        output_buffer

      end
    end
  end
end
