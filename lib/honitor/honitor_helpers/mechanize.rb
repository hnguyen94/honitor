# frozen_string_literal: true

module HonitorHelpers
  class Mechanize
    def self.beautify(xml_list:)
      xml_list.map(&:content)
    end
  end
end
