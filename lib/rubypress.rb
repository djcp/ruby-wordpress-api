$LOAD_PATH.unshift(File.dirname(__FILE__)) unless $LOAD_PATH.include?(File.dirname(__FILE__))

require 'xmlrpc/client'
require 'rubypress/client'

unless defined?(ActiveSupport)
  class Hash

    def deep_merge!(other_hash)
      other_hash.each_pair do |k, v|
        tv = self[k]
        self[k] = tv.is_a?(Hash) && v.is_a?(Hash) ? tv.deep_merge(v) : v
      end
      self
    end

    def deep_merge(other_hash)
      dup.deep_merge!(other_hash)
    end

  end
end


require 'pp'

class XMLRPC::Client
  def set_debug
    @http.set_debug_output($stderr);
  end
end
