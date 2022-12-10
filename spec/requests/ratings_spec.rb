require 'rails_helper'

RSpec.describe 'Ratings API', type: :request do
  describe 'GET /api/v1/ratings' do
    let!(:ratings) { create_list(:rating, 2) }

    it 'returns a list of ratings' do
      get '/api/v1/ratings'
      expect(response).to have_http_status(:ok)
    end

    it 'paginates the ratings' do
      get '/api/v1/ratings', params: { per_page: 1 }
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end

  describe 'POST /api/v1/ratings' do
    let(:ratable) { create(:post, user: create(:user)) }
    let!(:rating_user) { create(:user) }

    it 'creates a rating' do
      post '/api/v1/ratings', params: { rating: { user_id: rating_user.id, post_id: ratable.id, value: 1 } }
      expect(response).to have_http_status(:created)
    end

    it 'sets the rating value' do
      post '/api/v1/ratings', params: { rating: { user_id: rating_user.id, post_id: ratable.id, value: 5 } }
      expect(JSON.parse(response.body)['value']).to eq(5)
    end

    it 'raises error when user_id is missing' do
      post '/api/v1/ratings', params: { rating: { post_id: ratable.id, value: 1 } }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'raises error when post_id is missing' do
      post '/api/v1/ratings', params: { rating: { user_id: rating_user.id, value: 1 } }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'raises error when value is missing' do
      post '/api/v1/ratings', params: { rating: { user_id: rating_user.id, post_id: ratable.id } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
