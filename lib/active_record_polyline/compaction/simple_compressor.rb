# frozen_string_literal: true

require 'rgeo'

module ActiveRecordPolyline
  module Compaction
    class SimpleCompressor < Base
      def initialize(distance: 100)
        @distance = distance
        @factory = RGeo::Geographic.spherical_factory
      end

      def addable?(location)
        return true if @polyline.points.empty?

        distant?(@polyline.points.last, location)
      end

      def distant?(point1, point2)
        pt1 = @factory.point(point1[:longitude], point1[:latitude])
        pt2 = @factory.point(point2[:longitude], point2[:latitude])
        pt2.distance(pt1) > @distance
      end
    end
  end
end
