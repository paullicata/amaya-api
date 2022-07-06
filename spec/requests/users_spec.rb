require 'rails_helper'

RSpec.describe '/users', type: :request do
  let(:valid_attributes) do
    { username: 'plicata',
      password: 'password1234',
      password_confirmation: 'password1234',
      email: 'plicata18@gmail.com',
      first_name: 'Paul',
      last_name: 'Licata' }
  end

  let(:invalid_attributes) do
    { foo: 'bar', bar: 'foo' }
  end

  let(:valid_sign_in_attributes) do
    { email: 'plicata18@gmail.com', password: 'password1234' }
  end

  let(:invalid_sign_in_attributes) do
    { email: 'bar', password: 'foo' }
  end

  let(:valid_headers) do
    {}
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      User.create! valid_attributes
      get '/users', headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      user = User.create! valid_attributes
      get "/users/#{user.id}", as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new User' do
        expect {
          post '/users',
               params: { user: valid_attributes }, headers: valid_headers, as: :json
        }.to change(User, :count).by(1)
      end

      it 'renders a JSON response with the new user' do
        post '/users',
             params: { user: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new User' do
        expect {
          post '/users',
               params: { user: invalid_attributes }, as: :json
        }.to change(User, :count).by(0)
      end

      it 'renders a JSON response with errors for the new user' do
        post '/users',
             params: { user: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { username: 'plicata',
          password: 'password1234',
          email: 'plicata18@gmail.com',
          first_name: 'Paul',
          last_name: 'Licata' }
      end

      it 'updates the requested user' do
        user = User.create! valid_attributes
        patch "/users/#{user.id}", params: { user: new_attributes }, headers: valid_headers, as: :json
        user.reload
        expect(user.username).to eq('plicata')
        expect(user.password).to eq('password1234')
        expect(user.email).to eq('plicata18@gmail.com')
        expect(user.first_name).to eq('Paul')
        expect(user.last_name).to eq('Licata')
      end

      it 'renders a JSON response with the user' do
        user = User.create! valid_attributes
        patch "/users/#{user.id}", params: { user: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the user' do
        user = User.create! valid_attributes
        patch "/users/#{user.id}", params: { user: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'POST sessions#create' do
    context 'with valid parameters' do
      it 'signs in a user' do
        User.create! valid_attributes
        post '/users/sign_in',
               params: { user: valid_sign_in_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not sign in a user' do
        User.create! valid_attributes
        post '/users/sign_in',
             params: { user: invalid_sign_in_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested user' do
      user = User.create! valid_attributes
      expect {
        delete "/users/#{user.id}", headers: valid_headers, as: :json
      }.to change(User, :count).by(-1)
    end
  end
end
