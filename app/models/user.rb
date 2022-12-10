# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  login      :citext           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_login  (login) UNIQUE
#

class User < ApplicationRecord
  validates :login, presence: true, uniqueness: { case_sensitive: true }
  has_many :posts, dependent: :destroy, inverse_of: :user
end
