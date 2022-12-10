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
FactoryBot.define do
  factory :rating do
    post
    user
    value { [1, 5].sample }
  end
end
