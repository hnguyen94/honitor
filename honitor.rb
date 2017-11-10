# frozen_string_literal: true

require 'pry'
require 'pry-byebug'
require_relative 'honitor_bot'

website = HonitorBot.new(link: 'https://hamburg.craigslist.de/d/foto-video/search/pha', dom_class: '.result-title')
website.check_changes(time_interval: 10, random: true)
