# frozen_string_literal: true

require 'matrix'

module ActiveRecordPolyline
  module Compaction
    class VectorCompressor < SimpleCompressor
      compress_after_push

      def initialize(distance: 100)
        super
      end

      def addable?(location)
        return true if @polyline.points.empty?
        return distant?(@polyline.points.last, location) if @polyline.points.size == 1

        true
      end

      def compress_after_push
        return if @polyline.points.size < 3

        @polyline.points.delete_at(-2) if nearly_same_direction?(second_from_last_vec, last_vec)
      end

      def last_vec
        two_point_to_vec(@polyline.points.last(2).first, @polyline.points.last)
      end

      def second_from_last_vec
        two_point_to_vec(@polyline.points.last(3).first, @polyline.points.last(2).first)
      end

      def two_point_to_vec(from, to)
        each_norm = %i[longitude latitude].map { |key| to[key] - from[key] }
        Vector[*each_norm]
      end

      def nearly_same_direction?(vec1, vec2)
        vec1.normalize.dot(vec2.normalize) > 0.93
      end
    end
  end
end
