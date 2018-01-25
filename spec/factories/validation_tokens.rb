# frozen_string_literal: true

FactoryBot.define do
  factory :validation_token do
    token '987654'
    phone_id 1
  end
end
