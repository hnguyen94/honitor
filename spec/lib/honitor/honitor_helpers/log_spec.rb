require 'spec_helper'

describe HonitorHelpers::Log do
  describe '#show_time' do
    it 'returns the time formatted' do
      expect(described_class.show_time).to eq(Time.now.strftime('%a,%e %b %Y %H:%M:%S %z'))
    end
  end
end