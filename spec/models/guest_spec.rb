RSpec.describe Guest, type: :model do
  context 'Associations' do
    it { is_expected.to have_many :reservations }
  end

  context 'Validations' do
    subject { create(:guest) }
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
    it { is_expected.to validate_presence_of :email }

    it { is_expected.to validate_uniqueness_of :email }

    context 'email format if present' do
      before { allow(subject).to receive(:email?).and_return(true) }

      it { is_expected.to allow_value("test@testing.com").for(:email) }
      it { is_expected.not_to allow_value("test_email").for(:email) }
    end
  end
end