require "spec_helper"

describe Rack::SecureUpload::Middleware do
  let(:env) { Rack::MockRequest.env_for('/', method: :post, params: {foo: file}) }
  let(:file) { Rack::Multipart::UploadedFile.new(__FILE__) }
  let(:scanner) { double setup: true, scan: true }
  let(:options) { {} }
  subject { Rack::SecureUpload::Middleware.new(->env { ":)" }, scanner, options) }

  it "scans" do
    expect(scanner).to receive(:scan).once.and_return(true)
    expect(subject.call(env)).to eq(":)")
  end
  it "returns 406" do
    expect(scanner).to receive(:scan).and_return(false)
    expect(subject.call(env)).to match_array([406, hash_including, match_array([//])])
  end

  context "with multiple uploaded files" do
    let(:env) { Rack::MockRequest.env_for('/', method: :post, params: {foo: file, bar: file, zoo: file}) }

    it "scans multiple times" do
      expect(scanner).to receive(:scan).exactly(3).times
      expect(subject.call(env)).to eq(":)")
    end
  end
  context "without uplaod file" do
    let(:env) { Rack::MockRequest.env_for('/') }

    it "does not scan" do
      expect(scanner).not_to receive(:scan)
      expect(subject.call(env)).to eq(":)")
    end
  end
  context "fallback option" do
    context "fallback is a proc" do
      let(:fallback) { proc {} }
      let(:options) { {fallback: fallback} }

      it "calls fallback" do
        expect(fallback).to receive(:call).and_return('yay')
        allow(scanner).to receive(:scan).and_return(false)
        expect(subject.call(env)).to eq('yay')
      end
    end
    context "fallback is raise" do
      let(:options) { {fallback: :raise} }

      it "raises an exception" do
        allow(scanner).to receive(:scan).and_return(false)
        expect { subject.call(env) }.to raise_error(Rack::SecureUpload::InsecureFileError)
      end
    end
    context "fallback is other value" do
      let(:options) { {fallback: 'foo'} }

      it "returns 406" do
        allow(scanner).to receive(:scan).and_return(false)
        expect(subject.call(env)).to match_array([406, hash_including, match_array([//])])
      end
    end
  end
end
