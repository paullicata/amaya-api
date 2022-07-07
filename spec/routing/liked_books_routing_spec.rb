require 'rails_helper'

RSpec.describe LikedBooksController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/liked_books').to route_to('liked_books#index')
    end

    it 'routes to #show' do
      expect(get: '/liked_books/1').to route_to('liked_books#show', id: '1')
    end


    it 'routes to #create' do
      expect(post: '/liked_books').to route_to('liked_books#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/liked_books/1').to route_to('liked_books#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/liked_books/1').to route_to('liked_books#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/liked_books/1').to route_to('liked_books#destroy', id: '1')
    end
  end
end
