# frozen_string_literal: true

module ActiveRecordPolyline
  class Type < ActiveModel::Type::Value
    def initialize(compressor: nil)
      super()
      @options = compressor || {}
    end

    def serialize(value)
      value.to_s
    end

    def type
      :polyline
    end

    def changed_in_place?(raw_old_value, new_value)
      raw_old_value != serialize(new_value)
    end

    def deserialize(value)
      Polyline.new(value, **@options) unless value.nil?
    end

    private

    def cast_value(value)
      deserialize(value) if value.is_a?(::String) || value.is_a?(Array)
    end
  end
end
