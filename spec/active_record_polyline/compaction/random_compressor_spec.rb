# frozen_string_literal: true

RSpec.describe ActiveRecordPolyline::Compaction::RandomCompressor do
  describe '#addable?' do
    subject { instance.addable?(location) }

    let(:location) { { longitude: 139.70057341768944, latitude: 35.68960571616146 } }

    context 'ratio 1.0' do
      let(:instance) { described_class.new(ratio: 1.0) }

      it { is_expected.to be true }
    end

    context 'ratio 0.0' do
      let(:instance) { described_class.new(ratio: 0.0) }

      it { is_expected.to be false }
    end
  end
end
