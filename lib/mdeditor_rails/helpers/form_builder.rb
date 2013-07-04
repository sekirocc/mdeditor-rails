module MdeditorRails
  module Helpers
    module FormBuilder
      extend ActiveSupport::Concern
      
      def mdtext_area(method, options = {})
        @template.send("mdtext_area", @object_name, method, objectify_options(options))
      end
    end
  end
end
