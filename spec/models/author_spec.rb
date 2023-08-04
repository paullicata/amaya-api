require 'rails_helper'

RSpec.describe Author, type: :model do

  subject { described_class.new(name: 'Eric Carle') }

  context 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end
    #it { should validate_presence_of(:first_name) }
    #it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:name) }

  end

  context 'Associations' do
    it { should have_many(:books) }
  end
end
