# frozen_string_literal: true

RSpec.describe ActiveRecordPolyline::Polyline do
  describe '.new' do
    subject { described_class.new(points) }

    context 'if points is polyline string' do
      let(:points) { 'gs{xE{vbtY' }

      it { is_expected.to be_a described_class }
    end

    context 'if points is array' do
      context 'returned value of FastPolyline.decode' do
        let(:points) { [[35.69988052965485, 139.7747044986591]] }

        it { is_expected.to be_a described_class }
      end

      context 'coordinates with key fields' do
        let(:points) { [{ longitude: 139.7747044986591, latitude: 35.69988052965485 }] }

        it { is_expected.to be_a described_class }
      end
    end

    context 'nothing given' do
      it { expect(described_class.new).to be_a described_class }
    end
  end

  describe '#to_s' do
    subject { instance.to_s }

    let(:instance) { described_class.new }

    context 'if @points include several points' do
      before do
        instance.instance_variable_set(:@points, [{ longitude: 139.7747044986591, latitude: 35.69988052965485 }])
      end

      it { is_expected.to eq 'gs{xE{vbtY' }
    end

    context 'if @points is empty' do
      it { is_expected.to eq '' }
    end
  end
end
