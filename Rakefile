require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/*_test.rb']
end

load 'lib/capybara/minitest/assertions/rdoc.rake'

task :default => :test
