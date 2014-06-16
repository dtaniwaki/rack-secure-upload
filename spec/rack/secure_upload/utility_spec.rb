require "spec_helper"

describe Rack::SecureUpload::Utility do
  subject { Class.new{ include Rack::SecureUpload::Utility }.new }
  
  describe "#traverse" do
    context "array" do
      it "yields the block" do
        targets = [1, 2, 3]
        traversed = []
        subject.traverse(targets) do |v|
          traversed << v
        end
        expect(traversed).to eq(targets)
      end
    end

    context "hash" do
      it "yields the block" do
        targets = {:a => 1, :b => 2, :c => 3}
        traversed = Set.new
        subject.traverse(targets) do |v|
          traversed << v
        end
        expect(traversed).to eq(Set.new(targets.keys + targets.values))
      end
    end

    context "complicated hash" do
      it "yields the block" do
        targets = {:a => [1, 2, 3], :b => {'x' => [0], 'y' => 'Y'}, :c => 3}
        traversed = Set.new
        subject.traverse(targets) do |v|
          traversed << v
        end
        expect(traversed).to eq(Set.new([:a, 1, 2, 3, :b, 'x', 0, 'y', 'Y', :c, 3]))
      end
    end
  end

  describe "#camelize" do
    it "camelizes" do
      expect(subject.camelize("test_test_test")).to eq("TestTestTest")
    end
  end
end
