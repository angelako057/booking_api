require "rails_helper"

RSpec.describe Api::V1::ReservationsController, type: :controller do
  let(:guest) { create(:guest, phone: [ "6391123421341" ]) }

  describe "GET create with valid attributes" do
    context "when valid" do 
      it "create new reservation" do
        post :create, { params: { start_date: DateTime.now, end_date: DateTime.now + 3.days, nights: 3, guests: 2, adults: 2, children: 0, infants: 0, status: "accepted", currency: "AUD", 
                          payout_price: "3800", security_price: "500", total_price: "4500", guest: { id: guest.id, first_name: guest.first_name, last_name: guest.last_name, phone: guest.phone, email: guest.email } } }
        data = JSON.parse(response.body)
        expect(data["message"]).to eq "Room successfully booked."
      end
    end

    context "when invalid params" do
      it "create new guest but reservation params is incomplete" do
        post :create, { params: { guests: 2, adults: 2, children: 0, infants: 0, status: "accepted", currency: "AUD", 
                          payout_price: "3800", security_price: "500", total_price: "4500", guest: { id: guest.id, first_name: guest.first_name, last_name: guest.last_name, phone: guest.phone, email: guest.email } } }
        data = JSON.parse(response.body)
        expect(data["message"]).to eq "Validation failed: Start date can't be blank, End date can't be blank, Nights can't be blank"
      end
    end

    context "when guest email params already existing" do
      let(:guest) { create(:guest, phone: [ "6391123421341" ], email: "guest@test.com") }

      it "will return error" do
        post :create, { params: { start_date: DateTime.now, end_date: DateTime.now + 3.days, nights: 3, guests: 2, adults: 2, children: 0, infants: 0, status: "accepted", currency: "AUD", 
                          payout_price: "3800", security_price: "500", total_price: "4500", guest: { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, phone: [ "6391123421341", "6391123421342" ], email: guest.email } } }
        data = JSON.parse(response.body)
        expect(data["message"]).to eq "Validation failed: Email has already been taken"
      end
    end
  end
end