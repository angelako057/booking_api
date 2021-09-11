class Api::V1::ReservationsController < ApplicationController
  def create
    @guest = Guest.find_by_id(guest_params[:id])

    ActiveRecord::Base.transaction do
      @guest = @guest ? update_guest_attributes : Guest.create!(guest_params)
      @guest.reservations.create!(new_reservation_params)
    end

    render json: { message: 'Room successfully booked.', status: 200 }
  rescue StandardError => exception
    render json: { message: exception.message, status: 401 }
  end

  private

  def guest_params
    _params = params[:guest].present? ? set_guest_params : new_guest_params
    _params.require(:guest).permit(:id, :first_name, :last_name, :email, phone: [])
  end

  def reservation_params
    _params = params[:reservation].present? ? params : set_params(params, model_key: :reservation)
    _params.require(:reservation).permit(:start_date, :end_date, :nights, :total_guests, :currency, :status, :payout_price, :security_price, :total_price, guest_details: {})
  end

  def guest_details
    {
      adults: params[:adults],
      children: params[:children],
      infants: params[:infants]
    }
  end

  def new_guest_params
    new_params = {
      first_name: params[:reservation][:guest_first_name],
      last_name: params[:reservation][:guest_last_name],
      email: params[:reservation][:guest_email],
      phone: params[:reservation][:guest_phone_numbers]
    }

    set_params(new_params, model_key: :guest)
  end

  def new_reservation_params
    new_params = reservation_params
    new_params[:total_guests] = params[:guests] || params[:reservation][:number_of_guests]
    new_params[:guest_details] = guest_details if reservation_params[:guest_details].nil?
    new_params[:currency] = params[:reservation][:host_currency] if reservation_params[:currency].nil?
    new_params[:payout_price] = params[:reservation][:expected_payout_amount] if reservation_params[:payout_price].nil?
    new_params[:security_price] = params[:reservation][:listing_security_price_accurate] if reservation_params[:security_price].nil?
    new_params[:status] = params[:reservation][:status_type] if reservation_params[:status].nil?
    new_params[:total_price] = params[:reservation][:total_paid_amount_accurate] if reservation_params[:total_price].nil?
    new_params
  end

  def update_guest_attributes
    @guest.update!(guest_params)
    @guest
  end

  def set_guest_params
    params[:guest][:phone] = [params[:guest][:phone]] if params[:guest][:phone].is_a?(String)
    set_params(params[:guest], model_key: :guest)
  end

  def set_params(event, options = {})
    _params = { options[:model_key] => event }
    ActionController::Parameters.new(_params)
  end
end
