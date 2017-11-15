# frozen_string_literal: true

require 'attributed_object'

class UserConfig
  include AttributedObject::Strict

  attribute :name, :string
  attribute :link, :string
  attribute :dom_class, :string
  attribute :interval, :integer, default: 30
  attribute :random, :boolean, default:   true
  attribute :log, :boolean, default: true
end
