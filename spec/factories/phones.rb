# frozen_string_literal: true

FactoryBot.define do
  factory :phone do
    number '79991714753'
    active false
    valid false
    user_id 1
  end
end
