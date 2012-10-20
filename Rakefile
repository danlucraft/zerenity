require 'rubygems'

require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/testtask'
require 'rcov/rcovtask'

Rake::RDocTask.new do |rdoc|
  rdoc.main = "README"
  rdoc.rdoc_files.include("README","CHANGELOG","lib/**/*.rb")
  rdoc.rdoc_dir = "doc"
end

Rake::TestTask.new do |test|
  test.test_files = ['test/ts_zerenity.rb']
end

task :stats  do
  require 'code_statistics'
  CodeStatistics.new(
    ["Code", "lib"],
    ["Units", "test"]).to_s
end


Rcov::RcovTask.new do |rcov|
  rcov.test_files = FileList['test/ts_zerenity.rb']
end
