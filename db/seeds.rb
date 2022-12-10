# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
require 'parallel'

ip_v4_addresses = []
50.times do |n|
  ip_v4_addresses << "192.168.#{n}.#{n}"
end

logins = []
100.times do
  logins << Faker::Internet.unique.username
end
User.insert_all(logins.map { |login| { login: login } })

all_user_ids = User.all.pluck(:id).to_a

200_000.times do |n|
  batch = []
  batch << {
    title: "Test Post #{n}",
    body: Faker::Lorem.paragraph,
    ip: ip_v4_addresses.sample,
    user: all_user_ids.sample,
  }

  next unless batch.size == 1000

  puts 'Importing batch of 1000 posts'
  Post.insert_all(batch)
  batch = [] # rubocop:disable Lint/UselessAssignment
end

# take random 150_000 posts and create ratings for them
rated_post_ids = Post.all.pluck(:id).sample(150_000)
users_ids = User.all.pluck(:id)

Parallel.map(rated_post_ids, in_threads: 10) do |post_id|
  ratings = []
  100.times do
    ratings << { post_id: post_id, user_id: users_ids.sample, value: rand(1..5) }
  end
  puts 'Importing batch of 100 ratings'

  Rating.insert_all(ratings.uniq)
rescue ActiveRecord::ConnectionTimeoutError => _e
  puts 'Connection timeout error, retrying'
  retry
end
