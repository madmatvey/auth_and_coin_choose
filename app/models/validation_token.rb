# frozen_string_literal: true

class ValidationToken < ApplicationRecord
  belongs_to :phone
  after_initialize :generate_token

  def generate_token
    self.token ||= SecureRandom.random_number(10**6).to_s if new_record?
  end

  def is_on_time?
    Time.at(created_at) + 30.minutes >= Time.now unless created_at.nil?
  end
end
