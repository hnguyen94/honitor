# frozen_string_literal: true
require 'pry'
require 'pry-byebug'
require 'rspec/core/rake_task'

require_relative 'lib/honitor'

task default: [:start]

task :start do
  Hydra.execute
end

task :init do
  ruby 'bin/setup.rb'
end

task :test do
  Honitor.new(instance: 'aboutyou-red-hoodie')
end

RSpec::Core::RakeTask.new(:spec)
