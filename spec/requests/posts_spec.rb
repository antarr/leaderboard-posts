require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /posts' do
    it 'returns http success' do
      get '/api/v1/posts'
      expect(response).to have_http_status(:success)
    end

    it 'returns paginated posts' do
      user = create(:user)
      create_list(:post, 11, user: user)
      get '/api/v1/posts'
      posts = JSON.parse(response.body)
      expect(posts.size).to eq(10)
    end
  end

  describe 'POST /posts' do
    it 'returns http success' do
      attributes = attributes_for(:post, :with_user)
      post '/api/v1/posts', params: { post: attributes }
      expect(response).to have_http_status(:created)
    end

    it 'raises error when user_login is missing' do
      attributes = attributes_for(:post)
      post '/api/v1/posts', params: { post: attributes }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'raises error when body is missing' do
      attributes = attributes_for(:post, :with_user)
      attributes.delete(:body)
      post '/api/v1/posts', params: { post: attributes }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'raises error when title is missing' do
      attributes = attributes_for(:post, :with_user)
      attributes.delete(:title)
      post '/api/v1/posts', params: { post: attributes }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'raises error when ip is missing' do
      attributes = attributes_for(:post, :with_user)
      attributes.delete(:ip)
      post '/api/v1/posts', params: { post: attributes }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'raises error when ip is invalid' do
      attributes = attributes_for(:post, :with_user)
      attributes[:ip] = 'invalid'
      post '/api/v1/posts', params: { post: attributes }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
