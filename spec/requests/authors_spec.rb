require 'rails_helper'


RSpec.describe '/authors', type: :request do

  let(:valid_attributes) do
    { name: 'Eric Carle' }
  end

  let(:invalid_attributes) do
    { foo: 'bar', bar: 'foo' }
  end

  before(:example) do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_user!).and_return(true)
  end

  let(:valid_headers) do
    {}
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Author.create! valid_attributes
      get authors_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      author = Author.create! valid_attributes
      get author_url(author), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Author' do
        expect {
          post authors_url,
               params: { author: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Author, :count).by(1)
      end

      it 'renders a JSON response with the new author' do
        post authors_url,
             params: { author: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Author' do
        expect {
          post authors_url,
               params: { author: invalid_attributes }, as: :json
        }.to change(Author, :count).by(0)
      end

      it 'renders a JSON response with errors for the new author' do
        post authors_url,
             params: { author: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { name: 'Roald Dahl' }
      end

      it 'updates the requested author' do
        author = Author.create! valid_attributes
        patch author_url(author),
              params: { author: new_attributes }, headers: valid_headers, as: :json
        author.reload
        expect(author.name).to eq('Roald Dahl')
      end

      it 'renders a JSON response with the author' do
        author = Author.create! valid_attributes
        patch author_url(author),
              params: { author: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the author' do
        author = Author.create! valid_attributes
        patch author_url(author),
              params: { author: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested author' do
      author = Author.create! valid_attributes
      expect {
        delete author_url(author), headers: valid_headers, as: :json
      }.to change(Author, :count).by(-1)
    end
  end
end
