# frozen_string_literal: true

module ActiveRecordPolyline
  # Mix-in to ActiveRecord::Base to make it enable
  # access attribute type of polyline
  module Extension
    extend ActiveSupport::Concern

    class_methods do
      # rubocop:disable Naming/PredicateName
      def has_polyline(name = :polyline, **options)
        attribute name, :polyline, **options
      end
      # rubocop:enable Naming/PredicateName
    end
  end
end
