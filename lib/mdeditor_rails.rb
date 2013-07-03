require "mdeditor_rails/engine"

module MdeditorRails
  autoload :Util, 'mdeditor_rails/util'
  module Helpers
    autoload :ViewHelper, 'mdeditor_rails/helpers/view_helper'
  end

  class<< self
    def root_path
      @root_path ||= Pathname.new(File.dirname(File.expand_path('../', __FILE__)))
    end

    def assets
      @assets ||= Util.precompile_assets
    end
  end
  
end
