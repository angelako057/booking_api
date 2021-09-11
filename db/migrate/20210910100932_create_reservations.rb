class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.references :guest, foreign_key: true, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.integer :nights, null: false
      t.integer :total_guests, null: false
      t.json :guest_details
      t.string :currency, null: false
      t.string :status, null: false
      t.decimal :payout_price, null: false
      t.decimal :security_price, null: false
      t.decimal :total_price, null: false

      t.timestamps
    end
  end
end
