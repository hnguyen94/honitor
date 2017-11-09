# frozen_string_literal: true

require 'pry'
require 'pry-byebug'
require './push_notification'

website = PushNotification.new(link: 'https://hamburg.craigslist.de/d/foto-video/search/pha', dom_class: '.result-title')
website.check_changes(time_interval: 10, random: true)
