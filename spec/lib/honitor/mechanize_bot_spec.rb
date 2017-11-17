require 'spec_helper'

describe MechanizeBot do
  describe '.fetch_dom_objects' do
    it 'returns a list of elements' do
      bot = MechanizeBot.new(link: TEST_CONFIG.link, dom_class: TEST_CONFIG.dom_class)
      elements = bot.fetch_dom_objects

      expect(elements).to be_a Array
      expect(elements.first.name).to eq('p')
      expect(elements.first.content).to eq('1') 
    end
  end
end