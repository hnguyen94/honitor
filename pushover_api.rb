# frozen_string_literal: true

require 'httparty'

class PushoverApi
  include HTTParty

  def initialize(token: ENV['APP_TOKEN'],
                 user: ENV['USER_TOKEN'])
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
