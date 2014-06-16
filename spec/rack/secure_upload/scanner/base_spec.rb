require "spec_helper"

describe Rack::SecureUpload::Scanner::Base do
  let(:klass) { Rack::SecureUpload::Scanner::Base }
  it "has private initialize method" do
    expect {
      klass.new
    }.to raise_error(Rack::SecureUpload::RuntimeError)
  end
  describe "subclass" do
    describe "options" do
      it "merges default options with argument options" do
        scanner = Class.new(klass) {
          def default_options
            {color: :green}
          end
        }.new(foo: :bar)
        expect(scanner.options).to eq(foo: :bar, color: :green)
      end
    end
    describe "with logger option" do
      let(:logger) { double }
      it "uses its own logger if available" do
        scanner = Class.new(klass).new(logger: logger)
        expect(scanner.logger).to eq(logger)
      end
    end
    describe "without logger option" do
      let(:logger) { double }
      it "uses its own logger if available" do
        scanner = Class.new(klass).new
        expect(scanner.logger).not_to eq(logger)
      end
    end
  end
end
