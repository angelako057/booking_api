RSpec.describe Reservation, type: :model do
  context 'Associations' do
    it { is_expected.to belong_to :guest }
  end

  context 'Validations' do
    subject { create(:reservation) }
    it { is_expected.to validate_presence_of :guest_id }
    it { is_expected.to validate_presence_of :start_date }
    it { is_expected.to validate_presence_of :end_date }
    it { is_expected.to validate_presence_of :nights }
    it { is_expected.to validate_presence_of :total_guests }
    it { is_expected.to validate_presence_of :currency }
    it { is_expected.to validate_presence_of :status }
    it { is_expected.to validate_presence_of :payout_price }
    it { is_expected.to validate_presence_of :security_price }
    it { is_expected.to validate_presence_of :total_price }
  end
end