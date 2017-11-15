# frozen_string_literal: true

require 'dotenv/load'
require 'colorize'
require 'yaml'
require 'pry'
require 'pry-byebug'

Dir.glob('lib/**/*.rb') { |file| require_relative file }

task default: [:start]

task :start do
  Honitor.start
end

task :init do
  ruby 'bin/setup.rb'
end
