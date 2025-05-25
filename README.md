# SymbolicDifferentiator

Gem для символьного дифференцирования полиномов с поддержкой многомерных выражений.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add symbolic_differentiator
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install symbolic_differentiator
```

## Usage

Basic example:

```ruby
require 'symbolic_differentiator'

result = SymbolicDifferentiator.differentiate("x^2 + 4*x + 3 + y", 'x')
puts result # => "2*x + 4"
```

Supported syntax:
Variables: single letters (x, y, z)

Operators: +, -, *, ^

Formats:

x^3

2*x*y

-5*y^2

3.14*z

!Limitations!:
Does not support:

    -High-order functions
    -I implicit multiplication (2x instead of 2*x)
    -Multi-letter variables

Examples:

Differentiating by x:
```ruby
expr = "3*x^2*y + 2*y^3 - x"
SymbolicDifferentiator.differentiate(expr, 'x') # => "6*x*y - 1"
```

Differentiating by y:
```ruby
expr = "x^3*cos(y) + 5*y^2"
SymbolicDifferentiator.differentiate(expr, 'y') # => "-x^3*sin(y) + 10*y"
```

Constants:
```ruby
SymbolicDifferentiator.differentiate("5", 'x') # => "0"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).
s
## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dakuznet/Symbolic-Differentiator.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).