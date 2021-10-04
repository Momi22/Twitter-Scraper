# frozen_string_literal: true

module TwitterService
  class TwitterRequest
    def request(topic)
      Timeout.timeout(10) do
        tweet_data = {}
        client = set_information
        client.search(topic, result_type: 'recent').take(1).collect do |tweet|
          tweet_data = { ref_id: tweet.id, text: tweet.text, screen_name: tweet.user.screen_name }
        end

        { status: 1, data: tweet_data }
      end
    rescue Timeout::Error
      { status: 0 }
    rescue StandardError
      { status: 0 }
    end

    def set_information
      Twitter::REST::Client.new do |config|
        config.consumer_key        = CONFIG[:twitter_key]
        config.consumer_secret     = CONFIG[:twitter_secret]
        config.access_token        = CONFIG[:access_token]
        config.access_token_secret = CONFIG[:access_token_secret]
      end
    end
  end
end
