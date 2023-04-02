# frozen_string_literal: true

require 'fast-polylines'

module ActiveRecordPolyline
  class Polyline
    attr_reader :points

    def initialize(points = [], **options)
      points = FastPolylines.decode(points, 5) if points.is_a?(String)
      points = points.map(&method(:cast_array_to_hash)) if points.first.is_a?(Array)
      @points = points

      compressor_name = options.delete(:name)
      @compressor = Compaction.lookup(compressor_name).new(**options)
      @compressor.apply self
    end

    def to_s
      FastPolylines.encode(@points.map { |point| [point[:latitude], point[:longitude]] }, 5)
    end

    def push(longitude:, latitude:, skip_compaction: false)
      @compressor.push(
        location: {
          longitude: longitude,
          latitude: latitude,
        },
        skip_compaction: skip_compaction
      )
    end

    private

    def cast_array_to_hash(point)
      { latitude: point[0], longitude: point[1] }
    end
  end
end
