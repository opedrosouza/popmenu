require 'rails_helper'

RSpec.describe LoadFileService, type: :actor do
  subject(:service) { described_class.call(file_path: file_path) }

  let(:path) { file_fixture('restaurant_data.json') }
  let(:file_path) { path.to_s }

  describe "#call" do
    it "succeeds" do
      expect(service).to be_a_success
    end

    it "returns the JSON data from the file" do
      expect(service.data).to eq(JSON.parse(path.read).with_indifferent_access)
    end

    context "when the import is nil" do
      let(:file_path) { nil }

      it "raises an error" do
        expect { service }.to raise_error(ServiceActor::ArgumentError)
      end
    end

    context "when the file is not found" do
      let(:file_path) { "" }

      it "raises an error" do
        expect { service }.to raise_error(Errno::ENOENT)
      end
    end

    context "when the file is not a JSON file" do
      let(:file_path) { file_fixture('restaurant_data.csv').to_s }

      it "raises an error" do
        expect { service }.to raise_error(JSON::ParserError)
      end
    end
  end
end
