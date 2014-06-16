module Rack
  module SecureUpload
    class RuntimeError < ::RuntimeError; end
    class InsecureFileError < RuntimeError; end
  end
end
