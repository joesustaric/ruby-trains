require 'pry'
require 'rspec'
require 'simplecov'

SimpleCov.start
SimpleCov.minimum_coverage 90

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

# Below allows capture of stdout and stderr for testing.
module OutputCapture
  def self.included(target)
    target.before do
      $stdout = @out = StringIO.new
      $stderr = @err = StringIO.new
    end

    target.after do
      $stdout = STDOUT
      $stderr = STDERR
    end
  end

  def stdout
    @out.string
  end

  def stderr
    @err.string
  end
end
