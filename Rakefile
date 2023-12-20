# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/extensiontask'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

task default: :test

Rake::ExtensionTask.new('vldmail') do |ext|
  ext.lib_dir = 'ext/vldmail/'
end

Rake::Task[:test].prerequisites << :compile
