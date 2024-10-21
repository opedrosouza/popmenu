require 'rails_helper'

RSpec.describe LoadDataService, type: :actor do
  subject(:service) { described_class.call(import: import) }

  let(:import) { create(:import) }

  describe "#call" do
    it "succeeds" do
      expect(service).to be_a_success
    end

    it "returns the data from the import" do
      expect(service.data).to eq(import.json_read)
    end

    context "when the import is nil" do
      let(:import) { nil }

      it "raises an error" do
        expect { service }.to raise_error(ServiceActor::ArgumentError)
      end
    end

    context "when there's no file in the import object" do
      let(:import) { build(:import) }

      it "raises an error" do
        expect { service }.to raise_error(ActiveStorage::FileNotFoundError)
      end
    end
  end
end
