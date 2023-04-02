# frozen_string_literal: true

module ActiveRecordPolyline
  module Compaction
    extend ActiveSupport::Autoload

    autoload :Base
    autoload :SimpleCompressor
    autoload :RandomCompressor
    autoload :VectorCompressor

    @registry = {}

    class << self
      attr_accessor :registry

      def register(name, klass = nil)
        registry[name] = klass
      end

      def lookup(name)
        registry[name] || default_compressor
      end

      def default_compressor
        @default_compressor ||= SimpleCompressor
      end
    end

    register(:simple_compressor, SimpleCompressor)
    register(:random_compressor, RandomCompressor)
    register(:vector_compressor, VectorCompressor)
  end
end
