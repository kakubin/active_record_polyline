# frozen_string_literal: true

RSpec.describe ActiveRecordPolyline::Type do
  describe '#serialize' do
    subject { instance.serialize(value) }

    let(:instance) { described_class.new }

    context 'if value is nil' do
      let(:value) { nil }

      it { is_expected.to eq '' }
    end

    context 'Polyline instance with @path empty' do
      let(:value) { ActiveRecordPolyline::Polyline.new([]) }

      it { is_expected.to eq '' }
    end

    context 'Polyline instance with @path filled' do
      let(:value) { ActiveRecordPolyline::Polyline.new([{ longitude: 139.8225984, latitude: 35.7833069 }]) }

      it { is_expected.to eq 'u|kyEgbltY' }
    end
  end

  describe '#changed_in_place?' do
    subject { instance.changed_in_place?('u|kyEgbltY', new_value) }

    let(:instance) { described_class.new }

    context 'if new value is not changed' do
      let(:new_value) { ActiveRecordPolyline::Polyline.new([{ longitude: 139.8225984, latitude: 35.7833069 }]) }

      it { is_expected.to be false }
    end

    context 'if new value is changes' do
      let(:new_value) { ActiveRecordPolyline::Polyline.new([{ longitude: 139.8225984, latitude: 35.7843069 }]) }

      it { is_expected.to be true }
    end
  end

  describe '#deserialize' do
    subject { instance.deserialize(value) }

    let(:instance) { described_class.new }

    context 'if value is nil' do
      let(:value) { nil }

      it { is_expected.to be_nil }
    end

    context 'Polyline instance with @path empty' do
      let(:value) { '' }

      it { is_expected.to be_a ActiveRecordPolyline::Polyline }
      it { expect(subject.instance_variable_get(:@points)).to eq [] }
    end

    context 'Polyline instance with @path filled' do
      let(:value) { 'u|kyEgbltY' }

      it { is_expected.to be_a ActiveRecordPolyline::Polyline }
      it { expect(subject.instance_variable_get(:@points)).to eq [{ longitude: 139.8226, latitude: 35.78331 }] }
    end
  end
end
