require 'rake/testtask'

task :default => [:test]

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.test_files = FileList['test/test_helper.rb']
  t.warning = true
  t.verbose = true
end
