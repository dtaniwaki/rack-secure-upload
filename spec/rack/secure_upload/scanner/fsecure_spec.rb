require "spec_helper"

describe Rack::SecureUpload::Scanner::Fsecure do
  let(:path) { 'tmp/fsecure_spec_target' }
  subject { Rack::SecureUpload::Scanner::Fsecure.new }

  before do
    ::File.open(path, 'w').close
  end

  describe "#setup" do
    subject { Rack::SecureUpload::Scanner::Fsecure.new(bin_path: 'tmp/fsecure_binary') }
    context "bin file exists" do
      before do
        ::File.open('tmp/fsecure_binary', 'w').close
      end
      it "does not raise an exception" do
        expect{ subject.setup }.not_to raise_error
      end
    end
    context "no bin file" do
      it "raises an exception" do
        expect{ subject.setup }.to raise_error(Rack::SecureUpload::SetupError)
      end
    end
  end

  describe "#scan" do
    context "normal files" do
      let(:command) { double run: lambda {} }
      it "detects an insecure file" do
        allow(subject).to receive(:command).and_return(command)
        expect(subject.scan(path)).to eq(true)
      end
    end

    context "insecure files" do
      let(:command) do
        d = double
        allow(d).to receive(:run) do
          ::FileUtils.rm path
        end
        d
      end
      it "does not detect normal file" do
        allow(subject).to receive(:command).and_return(command)
        expect(subject.scan(path)).to eq(false)
      end
    end
  end
end
