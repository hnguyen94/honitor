# frozen_string_literal: true

require 'httparty'

class PushoverApi
  include HTTParty

  def initialize(token: 'aw537xrdofcsx4r9paojh2hcv5k2cx',
                 user: 'ury8wqfqbhzuqg6ojcr4dia4o5k9tu')
    @token   = token
    @user    = user
  end

  def send_push_notification(message:)
    self.class.post('https://api.pushover.net/1/messages.json', body: {
      'token'   => @token,
      'user'    => @user,
      'message' => message
    })
  end
end
