require 'bundler'

require 'rubygems'
require 'rake'
require 'spec/rake/spectask'

Bundler::GemHelper.install_tasks


Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_opts = ['--options', "spec/spec.opts"]
  t.spec_files = FileList['spec/**/*_spec.rb']
end

