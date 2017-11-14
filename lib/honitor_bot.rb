# frozen_string_literal: true

require 'dotenv/load'
require 'colorize'
require 'yaml'
require 'pry'
require 'pry-byebug'

require_relative 'honitor/pushover_api'
require_relative 'honitor/mechanize_bot'

class HonitorBot
  class << self
    def start
      read_config
      check_changes(time_interval: @interval, random: @random)
    end

    def prepare_message
      if no_changes?
        puts show_time.to_s.green + " Found #{@current_dom_objects.count} items || " + 'No changes'.yellow
      else
        new_changes = @current_dom_objects - @old_dom_objects

        puts show_time.to_s.green + " Found new #{new_changes.count} items || " + 'Sent message!'.blue
        PushoverApi.send_push_notification(message: "On #{@name} there are #{new_changes.count} updated items.")
      end
    end

    def check_changes(time_interval: 5, random: true)
      loop do
        page = MechanizeBot.new(link: @link, dom_class: @dom_class)
        @current_dom_objects = beautify(xml_array: page.fetch_dom_objects)

        prepare_message

        @old_dom_objects = @current_dom_objects

        sleep time_interval unless random
        sleep(rand(1...time_interval))
      end
    end

    def no_changes?
      @old_dom_objects.nil? || @old_dom_objects == @current_dom_objects
    end

    def read_config
      config = YAML.load_file('config.yml')

      config['config'].each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end

    def beautify(xml_array:)
      xml_array.map(&:content)
    end

    def show_time
      Time.new.strftime('%a,%e %b %Y %H:%M:%S %z')
    end
  end
end

$stdout.reopen('logs/honitor_bot.log', 'a')
$stdout.sync = true
HonitorBot.start
