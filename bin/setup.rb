#!/usr/bin/env ruby

require 'colorize'
require 'fileutils'
require 'yaml'
require 'uri'

include FileUtils

LINK_REGEXP = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/
CLASS_REGEXP = /^.{1}\w+/

if File.file?('./config.yml')
  puts 'config.yml already exist'.yellow
  exit
end

print "What's the name of the website?: "
while name = gets.chomp
  break if !name.empty?
  print 'A man needs a name!'.red + ' Try it again: '
end

print 'Paste your link in!: '
while link = gets.chomp
  break if link =~ LINK_REGEXP
  print 'This is not a valid link!'.red + ' Try it again: '
end

print "What's the class name of that item list? (eg. .test-class): "
while dom_class = gets.chomp
  break if dom_class =~ CLASS_REGEXP
  print 'Looks like this is not a valid class!'.red + ' Does it start with a "." ? Try it again: '
end

print "Time interval for the bot in s?: "
while interval = gets.chomp.to_i
  break if interval > 0
  print 'This is not a number we can work with!'.red + ' Try it again: '
end

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
    print 'Please answer with y (yes) or n (no).'.red + ' Try it again: '
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
