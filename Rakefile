# frozen_string_literal: true
require 'pry'
require 'pry-byebug'
require 'rspec/core/rake_task'

require_relative 'lib/honitor'

task default: [:start]

task :start do
  Honitor.start
end

task :init do
  ruby 'bin/setup.rb'
end

RSpec::Core::RakeTask.new(:spec)