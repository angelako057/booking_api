FactoryBot.define do
  factory :reservation do
    guest_id { create(:guest).id }
    start_date { DateTime.now }
    end_date { DateTime.now + 2.days }
    nights { 2 }
    total_guests { 4 }
    currency { 'AUD' }
    status { 'accepted' }
    payout_price { 1300 }
    security_price { 500 }
    total_price { 2000 }
  end
end
