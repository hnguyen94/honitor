require 'spec_helper'

describe HonitorHelpers::Mechanize do
  describe '#beautify' do
    it 'beautifies the result of the scrapper' do
      page = MechanizeBot.new(link: TEST_CONFIG.link, dom_class: TEST_CONFIG.dom_class)

      expect(described_class.beautify(xml_list: page.fetch_dom_objects)).to eq(["1", "2", "3", "4", "5", "6", "7", "8", "9"])
    end
  end
end