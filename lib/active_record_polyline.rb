# frozen_string_literal: true

require_relative 'active_record_polyline/version'
require 'active_support/dependencies/autoload'

module ActiveRecordPolyline
  extend ActiveSupport::Autoload

  autoload :Type
  autoload :Extension
  autoload :Polyline
  autoload :Compaction

  ActiveSupport.on_load(:active_record) do
    ActiveModel::Type.register(:polyline, ActiveRecordPolyline::Type)
    ActiveRecord::Type.register(:polyline, ActiveRecordPolyline::Type)

    include(ActiveRecordPolyline::Extension)
  end
end
