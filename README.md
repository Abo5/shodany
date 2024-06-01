[![Gem Version](https://badge.fury.io/rb/shodany.svg)](https://badge.fury.io/rb/shodany)
[![Yard Docs](http://img.shields.io/badge/shodany-docs-blue.svg)](https://www.rubydoc.info/gems/shodany/1.0)
[![CI](https://github.com/Abo5/shodany/actions/workflows/ci.yml/badge.svg)](https://github.com/Abo5/shodany/actions)

# Shodany

Shodany is a versatile Ruby library for interacting with the Shodan API. It simplifies the process of searching for internet-connected devices, retrieving specific IP information, exploring vulnerabilities, and more.

## Table of Contents
- [Installation](#installation)
- [Usage](#usage)
  - [Setting Up](#setting-up)
  - [Retrieving Host Information](#retrieving-host-information)
  - [Searching for Vulnerabilities](#searching-for-vulnerabilities)
  - [General Shodan Search](#general-shodan-search)
  - [Listing All Ports](#listing-all-ports)
  - [Requesting a Shodan Scan](#requesting-a-shodan-scan)
  - [Getting Domain Information](#getting-domain-information)
- [Examples](#examples)
- [Development](#development)
- [Contributing](#contributing)
- [License](#license)
- [Code of Conduct](#code-of-conduct)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'shodany'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install shodany
```
### Setting Up

```ruby
require 'shodany'

client = Shodany.new("YOUR_SHODAN_API_KEY")
```

## Usage
```ruby
# get_domain_info_example.rb
# Specify the domain for which you want information
domain = "example.com"

# Begin exception handling
begin
  # Get domain information from Shodan
  domain_info = client.get_domain_info(domain)
  # Print the domain information
  puts domain_info
# Rescue block to catch and handle any errors
rescue Shodany::Error => e
  # Output the error message
  puts "An error occurred: #{e.message}"
end
```

```ruby
ip = "8.8.8.8"

# Begin exception handling
begin
  # Retrieve host information for the specified IP
  info = client.get_host_info(ip)
  # Print the retrieved information
  puts info
# Rescue block to catch and handle any errors
rescue Shodany::Error => e
  # Output the error message
  puts "An error occurred: #{e.message}"
end
```

```ruby
client = client.get_host_info("host ip e.g 192.168.10.100")
results = JSON.parse(client)
# Begin exception handling
begin
  # Retrieve host information for the specified IP
  puts "IP: #{results['ip_str']}"
  puts "Organization: #{results['org']}"
  puts "Operating System: #{results['os']}"
  puts "Ports: #{results['ports'].join(', ')}"
rescue Shodany::Error => e
  puts "An error occurred: #{e.message}"
end
```
```ruby
results = JSON.parse(client.search_exploits("log4j"))

results['matches'].each do |match|
  match.each { |key, value| puts "#{key}: #{value.is_a?(Array) ? value.join(', ') : value}" }
  puts "\n"
end
```
### [Other Usage Instructions]

## Examples

Refer to the `examples` directory for detailed examples of using Shodany in various scenarios.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/Abo5/shodany](https://github.com/Abo5/shodany). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/Abo5/shodany/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Shodany project's codebase, issue trackers, chat rooms, and mailing lists is expected to follow the [code of conduct](https://github.com/Abo5/shodany/blob/master/CODE_OF_CONDUCT.md).

---
