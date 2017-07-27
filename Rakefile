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
  activerecord-42
  activerecord-50
  activerecord-51
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
