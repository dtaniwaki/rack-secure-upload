require 'rack/secure_upload/errors'

module Rack
  module SecureUpload
    module Scanner
      class Base
        attr_reader :options, :logger

        def initialize(options = {})
          raise RuntimeError, 'Abstract class can not be instantiated' if self.class == Rack::SecureUpload::Scanner::Base
          @options = default_options.merge(options)
        end

        def scan(path)
          # Scan the file here
        end

        def logger
          options[:logger] || Rack::SecureUpload.logger
        end

        private

        def default_options
          {}
        end
      end
    end
  end
end
