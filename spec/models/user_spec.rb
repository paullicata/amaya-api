require 'rails_helper'


RSpec.describe User, type: :model do
  subject do
    described_class.new(username: 'plicata',
                        password: 'password1234',
                        email: 'plicata18@gmail.com',
                        first_name: 'Paul',
                        last_name: 'Licata')
  end

  context 'Validations' do


    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:email) }

  end
end
