#!/usr/bin/env ruby

require 'colorize'
require 'fileutils'
require 'yaml'
include FileUtils

if File.file?('./config.yml')
  puts 'config.yml already exist'.yellow
  exit
end

print "What's the name of the website?: "
name = gets.chomp

print 'Paste your link in!: '
link = gets.chomp

print "What's the class name of that item list? (eg. .test-class): "
dom_class = gets.chomp

print "Time interval for the bot in s?: "
interval = gets.chomp.to_i

print "Random interval? (y/n): "
while random = gets.chomp
  case random
  when 'y'
    random = true
    break
  when 'n'
    random = false
    break
  else
    puts 'Please do it again!'
  end
end

config = {
  'config' => {
    'name'      => name,
    'link'      => link,
    'dom_class' => dom_class,
    'interval'  => interval,
    'random'    => random
  }
}

File.write('config.yml', config.to_yaml)
puts 'config.yml was created'.green
