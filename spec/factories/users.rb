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
FactoryBot.define do
  factory :user do
    login { Faker::Internet.unique.username }
  end
end
