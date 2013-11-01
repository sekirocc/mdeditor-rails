module MdeditorRails
  module Helpers
    module FormHelper
      extend ActiveSupport::Concern
      
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::JavaScriptHelper
      
      def mdtext_area(object_name, method, options = {})

        element_id = 'wmd-input'
        element_class = 'wmd-input'
        attributes = options.merge({:type => 'text/plain', :id => element_id, :name => options.delete('name'), :class => element_class })
        

        if defined?(ActionView::Base::InstanceTag)
          instance_tag = ActionView::Base::InstanceTag.new(object_name, method, self, options.delete(:object))
          instance_tag.send(:add_default_name_and_id, options) if options[:id].blank?
          output = instance_tag.to_text_area_tag(attributes)
        else
          instance_tag = ActionView::Helpers::Tags::TextArea.new(object_name, method, self, attributes)
          instance_tag.send(:add_default_name_and_id, options)  if options[:id].blank?
          output = instance_tag.render
        end
        
        output_buffer = ActiveSupport::SafeBuffer.new
        output_buffer << Util.html_tag(self) { output }
        output_buffer << javascript_tag(Util.js_code)
        output_buffer

      end
    end
  end
end
