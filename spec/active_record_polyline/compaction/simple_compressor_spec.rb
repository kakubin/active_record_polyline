# frozen_string_literal: true

RSpec.describe ActiveRecordPolyline::Compaction::SimpleCompressor do
  describe '#addable?' do
    subject { instance.addable?(location) }

    let(:location) { { longitude: 139.70057341768944, latitude: 35.68960571616146 } }

    before { instance.instance_variable_set(:@polyline, PolylineMock.new(points, nil)) }

    context 'if it has no point' do
      let(:instance) { described_class.new }
      let(:points) { [] }

      it { is_expected.to be true }
    end

    context 'if it already has points' do
      let(:points) { [{ longitude: 139.76727685840714, latitude: 35.681059713420865 }] }

      context 'if its too close' do
        let(:instance) { described_class.new }

        it { is_expected.to be true }
      end

      context 'if its too close for defined threshold' do
        let(:instance) { described_class.new(distance: 10000) }

        it { is_expected.to be false }
      end
    end
  end
end
