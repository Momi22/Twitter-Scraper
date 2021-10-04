# frozen_string_literal: true

class TwitterScraper < ApplicationRecord
  validates_presence_of :ref_id, :text

  class << self
    def send_request(ip, topic)
      limitation = Limitation.find_or_initialize_by(identifier: ip.to_s)
      if limitation.valid_to_try?
        limitation.try_request!
        req = TwitterService::TwitterRequest.new
        result = req.request(topic)

        return :unknown_error if result[:status].zero?

        build_scraper_record(result)
      else
        :exceed_try
      end
    end

    def build_scraper_record(hash = {})
      return if hash.empty?

      twitter_scraper = TwitterScraper.find_or_initialize_by(ref_id: hash[:ref_id])

      return unless twitter_scraper.id.nil?

      twitter_scraper.text = hash[:text]
      twitter_scraper.screen_name = hash[:screen_name]
      twitter_scraper.save
    end
  end
end
