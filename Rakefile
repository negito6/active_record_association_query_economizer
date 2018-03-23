#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs = ["test"]
  t.pattern = "test/**/*_test.rb"
  t.ruby_opts = ['-w']
end

task :default => :test

pwd = File.expand_path('../', __FILE__)

gemfiles = %w(
  activerecord-420
  activerecord-421
  activerecord-422
  activerecord-423
  activerecord-424
  activerecord-425
  activerecord-426
  activerecord-427
  activerecord-428
  activerecord-429
  activerecord-500
  activerecord-501
  activerecord-502
  activerecord-503
  activerecord-504
  activerecord-505
  activerecord-506
  activerecord-510
  activerecord-511
  activerecord-512
  activerecord-513
  activerecord-514
  activerecord-515
)

namespace :test do
  gemfiles.each do |gemfile|
    desc "Run Tests by #{gemfile}.gemfile"
    task gemfile do
      sh "BUNDLE_GEMFILE='#{pwd}/gemfiles/#{gemfile}.gemfile' bundle install --path #{pwd}/.bundle"
      sh "BUNDLE_GEMFILE='#{pwd}/gemfiles/#{gemfile}.gemfile' bundle exec rake -t test"
    end
  end

  desc "Run All Tests"
  task :all do
    gemfiles.each do |gemfile|
      Rake::Task["test:#{gemfile}"].invoke
    end
  end
end
