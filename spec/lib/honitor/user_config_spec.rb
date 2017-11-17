# frozen_string_literal: true

require 'spec_helper'

describe UserConfig do
  it 'gives a place to store the config' do
    attributes = {
      name: 'Hello! Im a name!',
      link: 'http://google.com',
      dom_class: '.superclass',
      interval: 5,
      random: true,
      log: false
    }

    config = described_class.new(attributes)

    attributes.each_key do |key|
      expect(config.send(key)).to eq(attributes[key])
    end
  end

  it 'raises an error when the type is not correct' do
    false_ttributes = {
      name: 'Hello! Im a name!',
      link: 'http://google.com',
      dom_class: '.superclass',
      interval: 'HA! IM NOT AN INTERVAL!',
      random: true,
      log: false
    }

    expect { described_class.new(false_ttributes) }.to raise_error(AttributedObject::TypeError)
  end
end
