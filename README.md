# ActiveRecordAssociationQueryEconomizer

Enables to define preloading conditions in the arguments of `has_one` / `has_many`.

Condition is defined as an array of symbolized method name or Proc object.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_record_association_query_economizer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_record_association_query_economizer

## Usage

```ruby
class SampleObject < ActiveRecord::Base
  has_many :sample_associations, preload_if: [:one_condition?, :another_condition?]

  def one_condition?
    true
  end

  def another_condition?
    false
  end
end
```

(Proc)

```ruby
class SampleObject < ActiveRecord::Base
  has_many :sample_associations, preload_if: -> (record) {
    true
  }
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/negito6/active_record_association_query_economizer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

### Testing
```
$ rake test:all
```

Run test for ActiveRecord version X.Y.Z
```
$ rake test:activerecord-X.Y.Z
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

