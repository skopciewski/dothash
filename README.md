# Dothash

[![Gem Version](https://badge.fury.io/rb/dothash.svg)](http://badge.fury.io/rb/dothash)
[![Code Climate](https://codeclimate.com/github/skopciewski/dothash/badges/gpa.svg)](https://codeclimate.com/github/skopciewski/dothash)

Hash to dot notation.

## Installation

Add this line to your application's Gemfile:

    gem 'dothash'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dothash

## Usage

```ruby
require "dothash"
hash = { x: { y: 1, z: { a1: 8, a2: 10 } }, v: [1, { y: 2, z: 3 }] }
dhash = Dothash::Hash.convert hash

puts dhash
# {"x.y"=>1, "x.z.a1"=>8, "x.z.a2"=>10, "v.0"=>1, "v.1.y"=>2, "v.1.z"=>3}

puts dh.class
# Hash
```

## Versioning

See [semver.org][semver]

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[semver]: http://semver.org/
