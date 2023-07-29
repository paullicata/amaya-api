require 'rails_helper'

RSpec.describe '/books', type: :request do
  include Warden::Test::Helpers
  # This should return the minimal set of attributes required to create a valid
  # Book. As you add validations to Book, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    { author_id: 2, title: 'Foo', copyright: '1999', grade_level: '2', genre: 'bar', description: 'Foo bar', cover: 'http://foo.bar' }
  end

  let(:invalid_attributes) do
    { foo: 'bar', bar: 'foo' }
  end


  before(:example) do
    Author.create(id: 2, first_name: 'foo', last_name: 'bar')
  end

  before(:example) do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_user!).and_return(true)
  end

  let(:valid_headers) do
    {}
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Book.create! valid_attributes
      get books_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      book = Book.create! valid_attributes
      get book_url(book), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Book' do
        expect {
          post books_url,
               params: { book: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Book, :count).by(1)
      end

      it 'renders a JSON response with the new book' do
        post books_url,
             params: { book: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Book' do
        expect {
          post books_url,
               params: { book: invalid_attributes }, as: :json
        }.to change(Book, :count).by(0)
      end

      it 'renders a JSON response with errors for the new book' do
        post books_url,
             params: { book: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { author_id: 2,
          title: 'Bar',
          copyright: '2000',
          grade_level: '3',
          genre: 'foo bar',
          description: 'Bar food',
          cover: 'http://test.com' }
      end

      it 'updates the requested book' do
        book = Book.create! valid_attributes
        patch book_url(book),
              params: { book: new_attributes }, headers: valid_headers, as: :json
        book.reload
        expect(book.title).to eq('Bar')
        expect(book.copyright).to eq('2000')
        expect(book.grade_level).to eq('3')
        expect(book.genre).to eq('foo bar')
        expect(book.description).to eq('Bar food')
        expect(book.cover).to eq('http://test.com')
      end

      it 'renders a JSON response with the book' do
        book = Book.create! valid_attributes
        patch book_url(book),
              params: { book: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the book' do
        book = Book.create! valid_attributes
        patch book_url(book),
              params: { book: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested book' do
      book = Book.create! valid_attributes
      expect {
        delete book_url(book), headers: valid_headers, as: :json
      }.to change(Book, :count).by(-1)
    end
  end
end
