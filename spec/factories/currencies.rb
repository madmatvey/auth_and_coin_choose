# frozen_string_literal: true

FactoryBot.define do
  factory :currency do
    bitcoin false
    lightcoin false
    dogecoin false
    user_id 1
  end
end
