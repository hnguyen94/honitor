# frozen_string_literal: true

require 'virtus'

class UserConfig
  include Virtus.model

  attribute :name, String
  attribute :link, String
  attribute :dom_class, String
  attribute :interval, Integer, default: 30
  attribute :random, Boolean, default:   true
  attribute :log, Boolean, default: true
end
