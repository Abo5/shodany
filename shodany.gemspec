require File.expand_path('lib/shodany/version', __dir__)

Gem::Specification.new do |spec|
  spec.name          = 'shodany'
  spec.version       = Shodany::VERSION
  spec.authors       = ['Maven', 'A88', 'Nazi']
  spec.email         = ['abdullahsaleh010@gmail.com']
  spec.summary       = 'A Ruby library for interacting with the Shodan API.'
  spec.description   = 'Shodany provides an easy-to-use interface for the Shodan API to search internet-connected devices, retrieve IP information, and search for vulnerabilities.'
  spec.homepage      = 'https://github.com/Abo5/shodany'
  spec.license       = 'MIT'
  spec.platform      = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.5.0'

  # Include all files from git tracking, excluding test, spec, and features
  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }

  # Ensure all necessary files are included in the gem
  spec.files += Dir['README.md', 'LICENSE', 'CHANGELOG.md', 'lib/**/*.rb', 'lib/**/*.rake', 'shodany.gemspec', '.github/*.md', 'Gemfile', 'Rakefile', 'examples/*']

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Define runtime and development dependencies
  spec.add_runtime_dependency 'json', '~> 2.0'
  spec.add_runtime_dependency 'net-http', '~> 0.1'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
