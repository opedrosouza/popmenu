require 'rails_helper'

RSpec.describe ImportDataJob, type: :job do
  describe '#perform_later' do
    let(:import) { create(:import) }
    subject(:job) { described_class.perform_later(import:) }

    it 'imports data from the import file' do
      expect { job }.to have_enqueued_job(described_class)
        .with(import: import)
        .on_queue('default')
    end
  end

  describe '#perform' do
    let(:import) { create(:import) }
    subject(:job) { described_class.perform_now(import: import) }

    it 'calls the ConvertService' do
      expect(ConvertService).to receive(:call).with(import: import)
      job
    end

    it 'imports data from the import file' do
      expect { job }.to change { Restaurant.count }.by(2)
        .and change { Menu.count }.by(4)
        .and change { MenuItem.count }.by(6)
        .and change { MenuItemVariant.count }.by(9)
    end
  end
end
