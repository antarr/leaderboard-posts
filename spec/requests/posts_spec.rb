require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /posts' do
    before do
      user = create(:user)
      create_list(:post, 11, user: user)
    end

    it 'returns http success' do
      get '/api/v1/posts'
      expect(response).to have_http_status(:success)
    end

    it 'returns paginated posts' do
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

  describe 'GET /top_posts' do
    before do
      posts = create_list(:post, 10)
      posts.each do |post|
        20.times do
          create(:rating, post: post)
        end
      end
    end

    it 'returns top N ratings' do
      get '/api/v1/top_posts', params: { per_page: 5 }
      posts = JSON.parse(response.body)
      expect(posts.size).to eq(5)
    end

    it 'returns the posts sorted by rating' do
      get '/api/v1/top_posts', params: { per_page: 5 }
      posts = JSON.parse(response.body)
      top = Post.find(posts.first['id']).ratings.average(:value)
      bottom = Post.find(posts.last['id']).ratings.average(:value)
      expect(top).to be > bottom
    end
  end
end
