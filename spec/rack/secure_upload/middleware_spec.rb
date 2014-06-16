require "spec_helper"

describe Rack::SecureUpload::Middleware do
  let(:env) { Rack::MockRequest.env_for('/') }
  let(:file) { Rack::Multipart::UploadedFile.new(__FILE__) }
  let(:scanner) { double scan: true }
  subject { Rack::SecureUpload::Middleware.new(->env { ":)" }, scanner) }

  context "with uploaded file" do
    let(:env) { Rack::MockRequest.env_for('/', method: :post, params: {foo: file}) }

    it "scans" do
      expect(scanner).to receive(:scan)
      subject.call(env)
    end

    context "with multiple uploaded files" do
      let(:env) { Rack::MockRequest.env_for('/', method: :post, params: {foo: file, bar: file, zoo: file}) }

      it "scans" do
        expect(scanner).to receive(:scan).exactly(3).times
        subject.call(env)
      end
    end
  end

  context "without uplaod file" do
    it "does not scan" do
      expect(scanner).not_to receive(:scan)
      subject.call(env)
    end
  end
end
