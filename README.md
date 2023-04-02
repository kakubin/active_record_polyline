# ActiveRecordPolyline



## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add active_record_polyline

## Usage

```ruby
ActiveRecord::Schema.define do
  create_table :trajectories, force: true do |t|
    t.text :polyline, null: false
  end
end

class Trajectory < ActiveRecord::Base
  has_polyline default: '', compressor: { name: :simple_compleressor, distance: 100 }
end

trajectory = Trajectory.new
trajectory.polyline.push(longitude: 139.70057341768944, latitude: 35.68960571616146)
trajectory.save # => true
trajectory.polyline.to_s # => "asyxEqgtsY"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kakubin/active_record_polyline. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/kakubin/active_record_polyline/blob/main/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the ActiveRecordPolyline project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/kakubin/active_record_polyline/blob/main/CODE_OF_CONDUCT.md).
