require 'rails_helper'

RSpec.describe '/liked_books', type: :request do

  let(:valid_attributes) do
    { user_id: 1, book_id: 2 }
  end

  let(:invalid_attributes) do
    { foo: 'bar', bar: 'foo' }
  end

  before(:example) do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_user!).and_return(true)
  end

  before(:example) do
    User.create(id: 1,
                username: 'plicata',
                password: 'password1234',
                email: 'plicata18@gmail.com',
                first_name: 'Paul',
                last_name: 'Licata')
    Author.create(id: 1, name: 'Eric Carle')
    Book.create(id: 2,
                author_id: 1,
                title: 'Foo',
                copyright: '1999',
                grade_level: '2',
                genre: 'Children\'',
                description: 'Foo bar',
                cover: 'http://foo.bar')
    Book.create(id: 3,
                author_id: 1,
                title: 'Bar',
                copyright: '2018',
                grade_level: '2',
                genre: 'Children\'',
                description: 'Bar foo',
                cover: 'http://foo.bar')
  end

  let(:valid_headers) {
    {}
  }

  describe 'GET /index' do
    it 'renders a successful response' do
      LikedBook.create! valid_attributes
      get liked_books_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      liked_book = LikedBook.create! valid_attributes
      get liked_book_url(liked_book), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new LikedBook' do
        expect {
          post liked_books_url,
               params: { liked_book: valid_attributes }, headers: valid_headers, as: :json
        }.to change(LikedBook, :count).by(1)
      end

      it 'renders a JSON response with the new liked_book' do
        post liked_books_url,
             params: { liked_book: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new LikedBook' do
        expect {
          post liked_books_url,
               params: { liked_book: invalid_attributes }, as: :json
        }.to change(LikedBook, :count).by(0)
      end

      it 'renders a JSON response with errors for the new liked_book' do
        post liked_books_url,
             params: { liked_book: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      before(:example) do
        User.create(id: 4,
                    username: 'test',
                    password: 'password1234',
                    email: 'test@gmail.com',
                    first_name: 'Paul',
                    last_name: 'Licata')
        Author.create(id: 2, name: 'Eric Carle')
        Book.create(id: 17,
                    author_id: 1,
                    title: 'Foo',
                    copyright: '1999',
                    grade_level: '2',
                    genre: 'bar',
                    description: 'Foo bar',
                    cover: 'http://foo.bar')
      end

      let(:new_attributes) {
        { user_id: 4, book_id: 17 }
      }

      it 'updates the requested liked_book' do
        liked_book = LikedBook.create! valid_attributes
        patch liked_book_url(liked_book),
              params: { liked_book: new_attributes }, headers: valid_headers, as: :json
        liked_book.reload
        expect(liked_book.user_id).to eq(4)
        expect(liked_book.book_id).to eq(17)
      end

      it 'renders a JSON response with the liked_book' do
        liked_book = LikedBook.create! valid_attributes
        patch liked_book_url(liked_book),
              params: { liked_book: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the liked_book' do
        liked_book = LikedBook.create! valid_attributes
        patch liked_book_url(liked_book),
              params: { liked_book: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested liked_book' do
      liked_book = LikedBook.create! valid_attributes
      expect {
        delete liked_book_url(liked_book), headers: valid_headers, as: :json
      }.to change(LikedBook, :count).by(-1)
    end
  end

  describe 'GET liked_books#most_popular' do
    let(:popular_books_list) do
      [{
           id: 2,
           author_id: 1,
           title: 'Foo',
           copyright: '1999',
           grade_level: '2',
           genre: 'Children\'',
           description: 'Foo bar',
           cover: 'http://foo.bar'
      }, {
          id: 3,
          author_id: 1,
          title: 'Bar',
          copyright: '2018',
          grade_level: '2',
          genre: 'Children\'',
          description: 'Bar foo',
          cover: 'http://foo.bar'
      }]
    end
    xit 'returns a list of LikedBooks in descending order' do
      LikedBook.create! valid_attributes

      get '/liked_books/most_popular', params: { liked_book: valid_attributes }, headers: valid_headers, as: :json
      binding.pry
      expect {

      }.to eq(:popular_books_list)
    end
  end

  describe 'GET liked_books#show_user_likes' do
    it 'returns a list of users liked books' do

    end
  end
end
