# frozen_string_literal: true

module ActiveRecordPolyline
  module Compaction
    class Base
      class << self
        def compress_before_push(method_name = :compress_before_push)
          @compress_before_method_name = method_name
        end

        def compress_after_push(method_name = :compress_after_push)
          @compress_after_method_name = method_name
        end
      end

      def apply(polyline)
        @polyline = polyline
      end

      def push(location:, skip_compaction:)
        return _push(location) if skip_compaction

        call_compaction_method(:before)
        _push(location) if addable?(location)

        call_compaction_method(:after)
      end

      private

      def addable?(*)
        true
      end

      def _push(location)
        @polyline.points.push(location)
      end

      def call_compaction_method(type)
        method_name = self.class.instance_variable_get(:"@compress_#{type}_method_name")
        return if method_name.nil?

        public_send(method_name)
      end
    end
  end
end
