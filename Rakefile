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

# set an array ["4.2.0", "4.2.1", ... "4.2.9", "5.0.0", "5.0.1", ... "5.1.0", ... "5.1.6", "5.2.0"]
activerecord_versions =
  { "4.2" => (0..9).to_a,
    "5.0" => (0..6).to_a,
    "5.1" => (0..6).to_a,
    "5.2" => [0..3].to_a,
  }.map do |base_version, tiny_versions|
    tiny_versions.map { |tiny_version| "#{base_version}.#{tiny_version}" }
  end.flatten

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
