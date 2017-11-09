# frozen_string_literal: true

require 'mechanize'
require 'awesome_print'
require './pushover_api'

class PushNotification
  attr_accessor :dom_class, :page, :dom_class, :dom_objects, :link, :user_agent

  def initialize(link:, dom_class:)
    @agent      = Mechanize.new
    @user_agent = @agent.user_agent_alias = 'Mac Safari'
    @link       = link
    @page       = @agent.get(link)
    @dom_class  = dom_class
  end

  def fetch_dom_objects
    @page.search(@dom_class).to_a
  end

  def check_changes(time_interval: 5, random: true)
    loop do
      pushy = PushNotification.new(link: @link, dom_class: @dom_class)
      @current_dom_objects = beautify(xml_array: pushy.fetch_dom_objects)

      if @old_dom_objects.nil? || @old_dom_objects == @current_dom_objects
        puts "=" * 100
        puts "Found #{@current_dom_objects.count} items"
        puts 'No changes'
      else
        new_changes = @current_dom_objects - @old_dom_objects

        p 'Message will be sent..'
        PushoverApi.new.send_push_notification(message: new_changes.to_s)
      end

      current_to_old

      sleep time_interval unless random
      sleep(rand(1...time_interval))
    end
  end

  private

  def beautify(xml_array:)
    xml_array.map { |xml_string| xml_string.content.strip! }
  end

  def current_to_old
    @old_dom_objects = @current_dom_objects
  end
end
