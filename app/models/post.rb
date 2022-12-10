# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  ip         :string           not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
class Post < ApplicationRecord
  paginates_per 10

  belongs_to :user, inverse_of: :posts
  has_many :ratings, dependent: :destroy, inverse_of: :post

  validates :title, presence: true
  validates :body, presence: true
  validates :ip, presence: true, format: { with: /\A\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\z/ }

  delegate :login, to: :user, prefix: true
end
