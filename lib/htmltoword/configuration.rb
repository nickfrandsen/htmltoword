module Htmltoword
  class Configuration
    attr_accessor :default_templates_path, :custom_templates_path, :default_xslt_path, :custom_xslt_path

    def initialize
      @default_templates_path = File.join(File.expand_path('../', __FILE__), 'templates')
      @custom_templates_path = File.join(File.expand_path('../', __FILE__), 'templates')
      @default_xslt_path = File.join(File.expand_path('../', __FILE__), 'xslt')
      @custom_xslt_path = File.join(File.expand_path('../', __FILE__), 'xslt')
    end
  end
end
