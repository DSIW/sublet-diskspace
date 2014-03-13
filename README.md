# Diskspace

Shows how much left space you have on root partition.

## Requirements

* Ruby
* [subtle](http://subtle.subforge.org/)
* `df`

## Installation

Run `sur install diskspace`.

## Usage

Your subtle config file could be:
```ruby
screen 1 do
  bottom [:separator, :diskspace, :separator]
end

# ...

sublet :diskspace do
  colors 98 => "#FF2525", 95 => "#C53535", 80 => "#A54545", 70 => "#955555", 60 => "#856565"
  format_string "%.01f"
  human_size "GB"
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

MIT
