require 'rubygems'

require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/testtask'
require 'rcov/rcovtask'

SPEC = Gem::Specification.new do |spec|
  spec.name = "zerenity"
  spec.version = "1.3"
  spec.author = "Farrel Lifson"
  spec.email = "farrel.lifson@gmail.com"
  spec.homepage = "http://www.aimred.com/projects/zerenity"
  spec.platform = Gem::Platform::RUBY
  spec.summary = "A Zenity clone for Ruby"
  spec.files = Dir.glob("{lib,examples,test}/**/*")
  spec.require_path = "lib"
  spec.autorequire = "zerenity"
  spec.has_rdoc = true
  spec.extra_rdoc_files = ["README","CHANGELOG"]
end

Rake::GemPackageTask.new(SPEC) do |pkg|
  pkg.need_tar = true
end

Rake::RDocTask.new do |rdoc|
  rdoc.main = "README"
  rdoc.rdoc_files.include("README","CHANGELOG","lib/**/*.rb")
  rdoc.rdoc_dir = "doc"
end

Rake::TestTask.new do |test|
  test.test_files = 'test/ts_zerenity.rb' 
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
