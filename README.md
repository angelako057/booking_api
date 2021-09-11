# Booking API

Booking API is a single endpoint ruby on rails application that allows user to create a reservations based on submitted payloads.

## Set up
1. Run `bundle install` to check setup
2. Run `rake db:setup` and `rake db:migrate` to setup database.


## Testing Endpoint
1. Run `rails s` to start server
2. In another terminal/cmd run the following payload

```
curl -H "Accept: application/json" -H "Content-type: application/json" -d '{"start_date": "2021-03-12", "end_date": "2021-03-16", "nights": 4, "guests": 4, "adults": 2, "children": 2, "infants": 0, "status": "accepted", "guest": { "id": 1, "first_name": "Wayne", "last_name": "Woodbridge", "phone": "639123456789", "email": "wayne_woodbridge@bnb.com" }, "currency": "AUD", "payout_price": "3800.00", "security_price": "500", "total_price": "4500.00"}' http://localhost:3000/api/v1/reservations
```

or

```
curl -H "Accept: application/json" -H "Content-type: application/json" -d '{"reservation": { "start_date": "2021-03-12", "end_date": "2021-03-16", "expected_payout_amount": "3800.00", "guest_details": { "localized_description": "4 guests", "number_of_adults": 2, "number_of_children": 2, "number_of_infants": 0 }, "guest_email": "wayne_woodbridge@bnb.com", "guest_first_name": "Wayne", "guest_id": 1, "guest_last_name": "Woodbridge", "guest_phone_numbers": [ "639123456789", "639123456789" ], "listing_security_price_accurate": "500.00", "host_currency": "AUD", "nights": 4, "number_of_guests": 4, "status_type": "accepted", "total_paid_amount_accurate": "4500.00"}}' http://localhost:3000/api/v1/reservations
```

The code above should create a guest record, (if not yet existing on db) and reservation record.

## Running Test Scripts
1. Run `rake db:migrate RAILS_ENV=test`
2. Run `rspec`