require 'bundler'

require 'rubygems'
require 'rake'
require 'rspec/core/rake_task'

Bundler::GemHelper.install_tasks


RSpec::Core::RakeTask.new('spec') do |t|
  t.pattern = 'spec/**/*_spec.rb'
end

