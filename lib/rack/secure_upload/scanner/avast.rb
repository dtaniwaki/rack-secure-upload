require 'rack/secure_upload/scanner/base'

module Rack
  module SecureUpload
    module Scanner
      class Avast < Base
        def setup
          raise SetupError, "#{options[:bin_path]} is not found." unless ::File.exists?(options[:bin_path])
        end

        def scan(path)
          now_umask = ::File.umask(0)

          lock do
            output = command.run(path: path)
            logger.info output
          end

          ::File.exist?(path)
        ensure
          ::File.umask(now_umask)
        end

        private

        def lock
          ::File.open(options[:lockfile_path], 'w', 0666) do |f|
            f.flock(::File::LOCK_EX)
            begin
              yield
            ensure
              f.flock(::File::LOCK_UN)
            end
          end
        end

        def command
          Terrapin::CommandLine.new(options[:bin_path], "-p 1 :path", :expected_outcodes => [0, 1])
        end

        def default_options
          {
            :bin_path => "/usr/bin/avast",
            :lockfile_path => "/tmp/avast_lock"
          }
        end
      end
    end
  end
end
