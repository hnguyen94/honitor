require 'mechanize'

class MechanizeBot
  attr_accessor :page, :dom_class, :dom_objects, :link, :user_agent

  def initialize(link:, dom_class:)
    @agent = Mechanize.new
    @user_agent = @agent.user_agent_alias = 'Mac Safari'
    @link       = link
    @page       = @agent.get(link)
    @dom_class  = dom_class
  end

  def fetch_dom_objects
    @page.search(@dom_class).to_a
  end
end
