require 'simple_form'

module MdeditorRails
  module Hooks 
    module SimpleForm
      class MdeditorRailsInput < ::SimpleForm::Inputs::Base
        def input
          element_id = 'wmd-input'
          element_class = 'wmd-input'
          input_html_options.merge!({ :id => element_id, :class => element_class })
          
          output_buffer = ActiveSupport::SafeBuffer.new
          output_buffer << Util.html_tag(template) { @builder.text_area(attribute_name, input_html_options) }
          output_buffer << template.javascript_tag(Util.js_code)
          output_buffer

        end
      end
    end
  end
end

::SimpleForm::FormBuilder.map_type :mdtext_area, :to => MdeditorRails::Hooks::SimpleForm::MdeditorRailsInput
