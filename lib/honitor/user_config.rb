# frozen_string_literal: true

require 'attributed_object'

class UserConfig
  include AttributedObject::Strict


  attribute :name, String
  attribute :link, String
  attribute :dom_class, String
  attribute :interval, Integer, default: 30
  attribute :random, Boolean, default:   true
  attribute :log, Boolean, default: true
end
