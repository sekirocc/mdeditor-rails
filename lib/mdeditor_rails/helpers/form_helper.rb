module MdeditorRails
  module Helpers
    module FormHelper
      extend ActiveSupport::Concern
      
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::JavaScriptHelper
      
      def mdtext_area(object_name, method, options = {})
        instance_tag = ActionView::Base::InstanceTag.new(object_name, method, self, options.delete(:object))
        instance_tag.send(:add_default_name_and_id, options) if options[:id].blank?

        element_id = 'wmd-input'
        element_class = 'wmd-input'
        attributes = {:type => 'text/plain', :id => element_id, :name => options.delete('name'), :class => element_class }

        output_buffer = ActiveSupport::SafeBuffer.new
        output_buffer << Util.html_tag(self) { instance_tag.to_text_area_tag(attributes) }
        output_buffer << javascript_tag(Util.js_code)
        output_buffer

      end
    end
  end
end
