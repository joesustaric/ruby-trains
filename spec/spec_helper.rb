require 'pry'
require 'rspec'
require 'simplecov'

SimpleCov.start

# Rspec Configuration
# http://www.rubydoc.info/github/rspec/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  # Use color in STDOUT
  config.color = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation # :progress, :html, :textmate

  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
  end
end
