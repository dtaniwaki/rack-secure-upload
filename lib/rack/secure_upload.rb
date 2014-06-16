require "logger"
require "rack/secure_upload/errors"
require "rack/secure_upload/middleware"

module Rack
  module SecureUpload
    def self.logger
      @logger ||= ::Logger.new($stderr)
    end
  end
end
