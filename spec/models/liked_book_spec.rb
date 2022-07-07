require 'rails_helper'

RSpec.describe LikedBook, type: :model do

  subject do
    described_class.new(user_id: 1,
                        book_id: 2)
  end

  context 'Validations' do
    it 'it is valid with valid' do
      expect(subject).to be_valid
    end

    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:book_id) }
  end

end
