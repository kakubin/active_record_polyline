# frozen_string_literal: true

RSpec.describe ActiveRecordPolyline::Compaction::Base do
  describe '.compress_before_push' do
    context 'if method name is not given' do
      it do
        described_class.compress_before_push
        expect(described_class.instance_variable_get(:@compress_before_method_name)).to be :compress_before_push
      end
    end

    context 'if method name is given' do
      it do
        described_class.compress_before_push(:uniq_name)
        expect(described_class.instance_variable_get(:@compress_before_method_name)).to be :uniq_name
      end
    end
  end

  describe '.compress_after_push' do
    context 'if method name is not given' do
      it do
        described_class.compress_after_push
        expect(described_class.instance_variable_get(:@compress_after_method_name)).to be :compress_after_push
      end
    end

    context 'if method name is given' do
      it do
        described_class.compress_after_push(:uniq_name)
        expect(described_class.instance_variable_get(:@compress_after_method_name)).to be :uniq_name
      end
    end
  end

  describe '#push' do
    subject { instance.push(location: location, skip_compaction: skip_compaction) }

    let(:instance) { described_class.new }
    let(:location) { { longitude: nil, latitude: nil } }
    let(:skip_compaction) { false }

    before do
      described_class.instance_variable_set(:@compress_before_method_name, nil)
      described_class.instance_variable_set(:@compress_after_method_name, nil)
      polyline = ActiveRecordPolyline::Polyline.new([])
      instance.apply polyline
    end

    context 'skip comaction' do
      let(:skip_compaction) { true }

      it { is_expected.to be_truthy }
    end

    it 'check callable' do
      expect { subject }.not_to raise_error
    end
  end
end
