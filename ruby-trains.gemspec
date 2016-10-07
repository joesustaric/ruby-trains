lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'ruby_trains/version'

# http://guides.rubygems.org/specification-reference/

Gem::Specification.new do |s|
  s.name          = 'ruby-trains'
  s.version       = RubyTrains::VERSION
  s.summary       = 'Short one liner of what this gem does.'
  s.description   = 'A longer explanation of what this gem does'
  s.authors       = ['Joe Sustaric']
  s.email         = ['joe8307+github@gmail.com']
  s.files         = Dir['lib/**/*'] + Dir['bin/*'] + ['README.md'] # Plus other files needed
  s.test_files    = Dir['spec/**/*']
  s.homepage      = 'https://https://github.com/joesustaric/ruby-trains'
  s.license       = 'MIT'
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  # Below Add any Development and runtime dependencies
   s.add_development_dependency 'rspec', '~> 3.5.0'
   s.add_development_dependency 'rubocop', '~> 0.42.0'
   s.add_development_dependency 'pry', '~> 0.10.4'
   s.add_development_dependency 'guard-rspec', '~> 4.7.3'
   s.add_development_dependency 'rake', '~> 10.5.0'
   s.add_runtime_dependency 'clamp', '~> 1.0.0'
end
