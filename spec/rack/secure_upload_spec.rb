require "spec_helper"

describe Rack::SecureUpload do
  it "has a logger" do
    expect(Rack::SecureUpload.logger).to be_a(::Logger)
  end
end
