module Rack
  module SecureUpload
    module Utility
      def traverse(value, &block)
        if value.is_a?(Hash)
          value.each do |k, v|
            traverse(k, &block)
            traverse(v, &block)
          end
        elsif value.is_a?(Array)
          value.each do |v|
            traverse(v, &block)
          end
        else
          block.call(value)
        end
      end
    end
  end
end
