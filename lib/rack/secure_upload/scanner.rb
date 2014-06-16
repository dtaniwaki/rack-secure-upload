module Rack
  module SecureUpload
    module Scanner
    end
  end
end

Dir[File.join(File.dirname(__FILE__), 'scanner', '*.rb')].each do |f|
  require f
end
