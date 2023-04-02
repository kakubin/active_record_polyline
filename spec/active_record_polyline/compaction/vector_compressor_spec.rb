# frozen_string_literal: true

RSpec.describe ActiveRecordPolyline::Compaction::VectorCompressor do
  describe '#addable?' do
    subject { instance.addable?(location) }

    let(:instance) { described_class.new }
    let(:location) { { longitude: 139.70057341768944, latitude: 35.68960571616146 } }

    before { instance.instance_variable_set(:@polyline, PolylineMock.new(points, nil)) }

    context 'if it is empty' do
      let(:points) { [] }

      it { is_expected.to be true }
    end

    context 'if it has a point' do
      context 'if close' do
        let(:points) { [{ longitude: 139.70098690695536, latitude: 35.689903000942785 }] }

        it { is_expected.to be false }
      end

      context 'if distant' do
        let(:points) { [{ longitude: 139.76727685840714, latitude: 35.681059713420865 }] }

        it { is_expected.to be true }
      end
    end

    context 'if it has several points' do
      let(:points) do
        [
          { longitude: 139.7006932, latitude: 35.6897647 },
          { longitude: 139.7011508, latitude: 35.6897212 },
        ]
      end

      it { is_expected.to be true }
    end
  end

  describe 'compress_after_push' do
    subject { instance.compress_after_push }

    let(:instance) { described_class.new }
    let(:location) { { longitude: 139.70057341768944, latitude: 35.68960571616146 } }

    before { instance.instance_variable_set(:@polyline, PolylineMock.new(points, nil)) }

    context 'if it has one point' do
      let(:points) do
        [
          { longitude: 139.7006932, latitude: 35.6897647 },
        ]
      end

      it do
        expect { subject }.not_to(change { instance.instance_variable_get(:@polyline).points })
      end
    end

    context 'if it has one point' do
      let(:points) do
        [
          { longitude: 139.7006932, latitude: 35.6897647 },
          { longitude: 139.7011508, latitude: 35.6897212 },
        ]
      end

      it do
        expect { subject }.not_to(change { instance.instance_variable_get(:@polyline).points })
      end
    end

    context 'if it has more than three points' do
      context 'if on line' do
        let(:points) do
          [
            { longitude: 139.7005734, latitude: 35.6895669 },
            { longitude: 139.7006892, latitude: 35.6895669 },
            { longitude: 139.7011508, latitude: 35.6895669 },
          ]
        end

        it do
          subject
          expect(instance.instance_variable_get(:@polyline).points.size).to be 2
          expect(instance.instance_variable_get(:@polyline).points.last).to match({
                                                                                    longitude: 139.7011508,
                                                                                    latitude: 35.6895669,
                                                                                  })
        end
      end

      context 'if direction changed' do
        let(:points) do
          [
            { longitude: 139.7006892, latitude: 35.6895669 },
            { longitude: 139.7005734, latitude: 35.6895669 },
            { longitude: 139.7005734, latitude: 35.6895843 },
          ]
        end

        it do
          subject
          expect(instance.instance_variable_get(:@polyline).points.size).to be 3
          expect(instance.instance_variable_get(:@polyline).points.last).to match({
                                                                                    longitude: 139.7005734,
                                                                                    latitude: 35.6895843,
                                                                                  })
        end
      end
    end
  end
end
