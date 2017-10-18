# frozen_string_literal: true

require 'pry'
require 'pry-byebug'
require './push_notification'


reddit = PushNotification.new(link: 'https://www.ebay-kleinanzeigen.de/', dom_class: '.itemtile-title')
reddit.check_changes(time_interval: 10)
