require "tilt"

module Newgistics
  class Request
    attr_accessor :client

    def render(options = {})
      options.reverse_merge!(DEFAULTS)
      template = Tilt.new("#{root}/#{self.class.name.gsub('Newgistics','').underscore}.slim")
      template.render(self, options: options)
    end

    protected

    def partial(name, options = {})
      carrier = self.class.to_s.split('::')[1]
      template = Tilt.new("#{root}/partials/_#{name}.slim")
      template.render(self, options)
    end

    def root
      "#{File.dirname(__FILE__)}/views"
    end
  end
end