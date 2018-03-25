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

activerecord_versions = %w(
  4.2.0
  4.2.1
  4.2.2
  4.2.3
  4.2.4
  4.2.5
  4.2.6
  4.2.7
  4.2.8
  4.2.9
  5.0.0
  5.0.1
  5.0.2
  5.0.3
  5.0.4
  5.0.5
  5.0.6
  5.1.0
  5.1.1
  5.1.2
  5.1.3
  5.1.4
  5.1.5
)

namespace :test do
  activerecord_versions.each do |activerecord_version|
    desc "Run Tests with activerecord #{activerecord_version}"
    task "activerecord-#{activerecord_version}" do
      gemfile = "#{pwd}/gemfiles/test.gemfile"
      sh "VERSION=#{activerecord_version} BUNDLE_GEMFILE='#{gemfile}' bundle install --path #{pwd}/.bundle"
      sh "VERSION=#{activerecord_version} BUNDLE_GEMFILE='#{gemfile}' bundle exec rake -t test"
      sh "rm #{gemfile}.lock"
    end
  end

  desc "Run All Tests"
  task :all do
    activerecord_versions.each do |activerecord_version|
      Rake::Task["test:activerecord-#{activerecord_version}"].invoke
    end
  end
end
