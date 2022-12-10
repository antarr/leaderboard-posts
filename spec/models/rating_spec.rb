# == Schema Information
#
# Table name: ratings
#
#  id         :bigint           not null, primary key
#  value      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_ratings_on_post_id_and_user_id  (post_id,user_id) UNIQUE
#
require 'rails_helper'

RSpec.describe Rating, type: :model do
  describe 'associations' do
    it { should belong_to(:post) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:value) }
    it { should validate_inclusion_of(:value).in_array([1, 5]) }

    it 'should validate uniqueness of user_id scoped to post_id' do
      user = create(:user)
      post = create(:post, user: user)
      create(:rating, user: user, post: post)
      rating = build(:rating, user: user, post: post)
      expect(rating).to_not be_valid
    end
  end
end
