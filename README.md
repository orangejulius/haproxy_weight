# HaproxyWeight

haproxy\_weight is a command line script to safely and easily change weights of servers in an HAProxy backend.

## Usage

There are two usage modes

1.) just viewing the weights of the servers defined in your config file

    # haproxy_weight /path/to/your/haproxy.cfg
    your_first_server 50
    your_second_server 20

2.) changing the weight of a server

    # haproxy_weight/path/to/your/haproxy.cfg your_first_server 20

## Installation

Add this line to your application's Gemfile:

    gem 'haproxy_weight'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install haproxy_weight

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
