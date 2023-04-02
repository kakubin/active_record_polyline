# frozen_string_literal: true

module ActiveRecordPolyline
  module Compaction
    class RandomCompressor < Base
      def initialize(ratio: 0.5)
        @ratio = ratio
      end

      def addable?(*)
        rand < @ratio
      end
    end
  end
end
