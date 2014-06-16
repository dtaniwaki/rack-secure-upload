require "spec_helper"

describe Rack::SecureUpload::Scanner::Fsecure do
  let(:path) { 'tmp/fsecure_spec_target' }
  subject { Rack::SecureUpload::Scanner::Fsecure.new }

  before do
    ::File.open(path, 'w').close
  end
  after do
    ::FileUtils.rm path if ::File.exists?(path)
  end

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
