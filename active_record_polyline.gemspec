# frozen_string_literal: true

require_relative 'lib/active_record_polyline/version'

Gem::Specification.new do |spec|
  spec.name = 'active_record_polyline'
  spec.version = ActiveRecordPolyline::VERSION
  spec.authors = ['kakubin']
  spec.email = ['wetsand.wfs@gmail.com']

  spec.summary = 'handle Polyline object on ActiveRecord'
  spec.description = 'handle Polyline object on ActiveRecord'
  spec.homepage = 'https://github.com/kakubin/active_record_polyline'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord'
  spec.add_dependency 'activesupport'
  spec.add_dependency 'fast-polylines'
  spec.add_dependency 'matrix'
  spec.add_dependency 'rgeo'

  spec.add_development_dependency 'appraisal'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov'
end
