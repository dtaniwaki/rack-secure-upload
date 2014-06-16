require 'rack'
require 'rack/secure_upload/utility'
require 'rack/secure_upload/scanner'

module Rack
  module SecureUpload
    class Middleware
      include Utility

      def initialize(app, scanners, options = {})
        @app = app
        @scanners = [scanners].flatten.map { |scanner| scanner.is_a?(Symbol) ? Rack::SecureUpload::Scanner.const_get(camelize(scanner.to_s)).new : scanner }
        @scanners.each do |scanner|
          scanner.setup
        end
        @options = options
      end

      def call(env)
        params = Rack::Multipart.parse_multipart(env)

        if params && !params.empty?
          traverse(params) do |value|
            next unless [Tempfile, File].any?{ |klass| value.is_a?(klass) }

            unless scan value.path
              fallback = @options[:fallback]
              if fallback.respond_to?(:call)
                return fallback.call(env, params, value.path)
              elsif fallback.to_s == 'raise'
                raise InsecureFileError, "The uploaded file \"#{value.path}\" is insecure!"
              else
                return [406, {'content-type' => 'text/plain; charset=UTF-8'}, ['Insecure File(s) are found!']]
              end
            end
          end
        end

        @app.call(env)
      end

      private

      def scan(path)
        @scanners.any? do |scanner|
          unless res = scanner.scan(path)
            Rack::SecureUpload.logger.warn "#{scanner} found an insecure file: #{path}"
          end
          res
        end
      end
    end
  end
end
