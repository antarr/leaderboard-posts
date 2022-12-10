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
class Rating < ApplicationRecord
  belongs_to :post, inverse_of: :ratings
  belongs_to :user, inverse_of: :ratings

  validates :value, presence: true, inclusion: { in: [1, 5] }
  validates :user_id, uniqueness: { scope: :post_id }
end
