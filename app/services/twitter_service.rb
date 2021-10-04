# frozen_string_literal: true

module TwitterService
  class TwitterRequest
    def request(topic)
      client = set_information
      client.search(topic, result_type: 'recent').take(1).collect do |tweet|
        twitter_scraper = TwitterScraper.find_or_initialize_by(ref_id: tweet.id)

        next unless twitter_scraper.id.nil?

        twitter_scraper.text = tweet.text
        twitter_scraper.screen_name = tweet.user.screen_name
        twitter_scraper.save
      end

      { status: 1 }
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
