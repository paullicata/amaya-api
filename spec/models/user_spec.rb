require 'rails_helper'


RSpec.describe User, type: :model do
  subject do
    described_class.new(id: 1,
                        username: 'plicata',
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
    it { should validate_uniqueness_of(:username).ignoring_case_sensitivity }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { should validate_length_of(:username).is_at_least(3).is_at_most(50) }
    it { should validate_length_of(:email).is_at_most(255) }

  end

  describe 'following and unfollowing a user' do
    let(:michael) do
      User.create(id: 2,
                  username: 'michael',
                  password: 'password1234',
                  email: 'michael@gmail.com',
                  first_name: 'Michael',
                  last_name: 'Smith')
    end

    let(:archer) do
      User.create(id: 3,
                  username: 'archer',
                  password: 'password1234',
                  email: 'archer@gmail.com',
                  first_name: 'Archer',
                  last_name: 'Doe')
    end
    describe '#follow' do
      it 'allows a user to follow a user' do
        expect(michael.following?(archer)).to be false
        michael.follow(archer)
        expect(michael.following?(archer)).to be true
        expect(archer.followed_by?(michael)).to be true
        michael.unfollow(archer)
        expect(michael.following?(archer)).to be false
      end
    end

    describe '#unfollow' do
      it 'allows a user to follow a user' do
        michael.follow(archer)
        expect(michael.following?(archer)).to be true
        michael.unfollow(archer)
        expect(michael.following?(archer)).to be false
      end
    end

    # describe 'User relationship with LikedBooks' do
    #   it 'deletes the associated likedbook when the user is deleted' do
    #     michael.liked_books.create!(book_id: )
    #   end
    # end
  end
end
