# frozen_string_literal: true

class Limitation < ActiveRecord::Base
  after_initialize :set_max_limits

  def set_max_limits
    self.maximum_resend ||= 5
    self.maximum_try ||= 5
  end

  def try_request!
    if try_at.nil? || try_at <= 30.minutes.ago
      self.try_at = Time.now
      self.maximum_try = 5
    elsif try_at > 30.minutes.ago
      self.maximum_try = self.maximum_try - 1
    end

    save
  end

  def resent_request!
    if resend_at.nil? || resend_at <= 30.minutes.ago
      self.resend_at = Time.now
      self.maximum_resend = 5
    else
      self.maximum_resend = self.maximum_resend - 1
    end

    save
  end

  def valid_to_resend?
    resend_at.nil? || (maximum_resend.positive? && resend_at >= 30.minutes.ago) || resend_at < 30.minutes.ago
  end

  def expired_token?
    (!resend_at.nil? && resend_at <= 30.minutes.ago)
  end

  def valid_to_try?
    (try_at.nil? || (maximum_try.positive? && try_at >= 30.minutes.ago) || try_at < 30.minutes.ago)
  end

  def reset_max_limits!
    self.maximum_resend = 5
    self.maximum_try = 5

    save!
  end
end
