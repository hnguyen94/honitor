# frozen_string_literal: true

require 'colorize'
require 'dotenv/load'
require 'ostruct'
require 'yaml'

Dir[File.dirname(__FILE__) + '/**/*.rb'].each { |file| require file }

class Honitor
  def initialize(instance:)
    @instance = instance

    start
  end

  def start
    read_config
    switch_log(@user_config.log)
    mkdir 'logs'
    check_changes
  end

  def check_changes
    loop do
      page = MechanizeBot.new(link: @user_config.link, dom_class: @user_config.dom_class)
      @current_dom_objects = HonitorHelpers::Mechanize.beautify(xml_list: page.fetch_dom_objects)

      prepare_message

      @old_dom_objects = @current_dom_objects

      interval
    end
  end

  def prepare_message
    if no_changes?
      message = " Found #{@current_dom_objects.count} items || " + 'No changes'.yellow
    else
      message = " Found new #{new_changes.count} items || " + 'Sent message!'.blue

      new_changes = @current_dom_objects - @old_dom_objects
      content = ContentManager(app_name: @user_config.name, link: @user_config.link, change_count: new_changes.count)
      PushoverApi.send_push_notification(message: content.standard_text)
    end

    puts HonitorHelpers::Log.show_time.to_s.green + message
    puts @current_dom_objects
    puts
  end

  def no_changes?
    @old_dom_objects.nil? || @old_dom_objects == @current_dom_objects
  end

  def read_config
    config = YAML.load_file("configs/#{@instance}.yml")

    @user_config = UserConfig.new(config['config'])
    map_site_class
  end

  def map_site_class
    if @user_config.dom_class != nil 
      return
    end

    site_class_list = YAML.load_file("configs/site_class_list.yml")
    
    if site_class_list.nil?
      raise 'Dom class is nil and site_class_list.yml is not existing!'
    end

    site_class_list = OpenStruct.new(site_class_list)


    if @site_class_list.dig(@user_config.name).nil?
      raise 'Dom Class is nil and name is not existing in site_class_list!'
    end

    @user_config.dom_class = site_class_list.dig(@user_config.name)
  end

  def switch_log(log)
    if log
      puts "Log will be saved in logs/#{@instance}.log"
      $stdout.reopen("logs/#{@instance}.log", 'a')
      $stdout.sync = true
    end

    puts 'Log is turned off'
  end

  def mkdir(name)
    FileUtils.mkdir_p(name) unless File.directory?(name)
  end

  def interval
    sleep @user_config.interval unless @user_config.random
    sleep(rand(1..@user_config.interval))
  end
end
