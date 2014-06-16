require 'cocaine'
require 'rack/secure_upload/errors'

module Rack
  module SecureUpload
    module Scanner
      class Fsecure < Base
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
          Cocaine::CommandLine.new(options[:bin_path], "--auto --virus-action1=remove :path")
        end

        def default_options
          {
            :bin_path => "/usr/bin/fsav",
            :lockfile_path => "/tmp/fsav_lock"
          }
        end
      end
    end
  end
end
