# frozen_string_literal: true

class TwitterScraper < ApplicationRecord
  validates_presence_of :ref_id, :text

  def self.send_request(ip, topic)
    limitation = Limitation.find_or_initialize_by(identifier: "#{ip}")
    if limitation.valid_to_try?
      limitation.try_request!
      req = TwitterService::TwitterRequest.new
      result = req.request(topic)

      return :unknown_error if result[:status].zero?
    else
      return :exceed_try
    end
  end
end
