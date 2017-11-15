# frozen_string_literal: true

module HonitorHelpers
  class Log
    def self.show_time
      Time.new.strftime('%a,%e %b %Y %H:%M:%S %z')
    end
  end
end
