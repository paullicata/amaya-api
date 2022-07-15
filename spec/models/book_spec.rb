require 'rails_helper'

RSpec.describe Book, type: :model do

  # Runs when subject is called
  subject do
    described_class.new(id: 1,
                        author_id: 1,
                        title: 'Green Eggs and Ham',
                        copyright: '1960',
                        grade_level: '1',
                        genre: 'Children\'s',
                        description: 'Some description')

  end

  context 'Validations' do

    it 'is valid with valid attributes' do
      Author.create(id: 1, first_name: 'Foo', last_name: 'Bar')
      expect(subject).to be_valid
    end

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:author_id) }
  end

  context 'Associations' do

    it { should belong_to(:author) }

  end
end
