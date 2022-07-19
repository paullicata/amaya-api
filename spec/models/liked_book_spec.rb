require 'rails_helper'

RSpec.describe LikedBook, type: :model do

  let(:michael) do
    User.create(id: 2,
                username: 'michael',
                password: 'password1234',
                email: 'michael@gmail.com',
                first_name: 'Michael',
                last_name: 'Smith')
  end
  subject do
    described_class.new(user_id: michael.id,
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
