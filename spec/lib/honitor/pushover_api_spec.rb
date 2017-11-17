require 'spec_helper'

describe PushoverApi do
  describe '#send_push_notification' do
    it 'sends a call to pushover' do
      message = 'Hello! Im a message!'

      expect(described_class).to receive(:post).with(
        "https://api.pushover.net/1/messages.json",
        body: {
          'token' => ENV['APP_TOKEN'],
          'user'    => ENV['USER_TOKEN'],
          'message' => message
        }
      )

      described_class.send_push_notification(message: message)
    end
  end
end