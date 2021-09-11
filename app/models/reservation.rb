class Reservation < ApplicationRecord
  belongs_to :guest

  validates :guest_id, :start_date, :end_date, :nights, :total_guests, :currency, :status, :payout_price, :security_price, :total_price, presence: true
end
