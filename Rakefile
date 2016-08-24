# This will load the src directory into the LOAD_PATH
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'rspec/core/rake_task'
require 'rubocop/rake_task'

require 'ruby_trains/version'

RSpec::Core::RakeTask.new :spec

task spec: :rubocop
task :default => :spec

desc 'Run RuboCop on the lib and spec dirs'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb','spec/**/*.rb']
end

desc 'Build this Gem'
task :build do
    system "gem build my-project.gemspec"
end

desc 'Publish the gem to rubygems.org'
task :publish => :build do
    system "gem push my-project-#{MyProject::VERSION}.gem"
end
