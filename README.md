# Leaderboard Posts

Leaderboard Posts is a Ruby on Rails application that implements a RESTful API for creating, rating, and retrieving posts. It is designed to store posts, ratings, and users in a PostgreSQL database.

## Installation

To install and use Leaderboard Posts, please follow the instructions below:

1. Install the latest the version of Ruby specified in the `.ruby-version` file.
2. Install and configure PostgreSQL.
3. Clone the source code from GitHub: `git clone https://github.com/antarr/leaderboard-posts.git`
4. Change into the project directory: `cd leaderboard-posts`
5. Install the required gems: `bundle install`
6. Set up the database: `rails db:migrate`
7. Load the seed data: `rails db:seed`
8. Start the server: `rails server`

## Usage

To use the Leaderboard Posts API, you can send HTTP requests to the following endpoints:

### Create a New Post

To create a new post, send a `POST` request to `/posts` with the following parameters:

* `title` - the title of the post (required)
* `body` - the body of the post (required)
* `login` - the login of the user who created the post (required)
* `ip` - the IP address of the user who created the post (required)

If the user does not exist, they will be created. On success, the response will include post attributes with user attributes. On failure, the response will include validation errors.

### Rate a Post

To rate a post, send a `POST` request to `/ratings` with the following parameters:

* `post_id` - the ID of the post to be rated (required)
* `user_id` - the ID of the user who is rating the post (required)
* `value` - the rating value from 1 to 5 (required)

Users can only rate each post once. The response will include the average post rating.

### Get Top Posts

To get the top N posts by average rating, send a `GET` request to `/posts?limit=N`, where N is the number of posts to retrieve. The response will include an array of post attributes (id, title, body).

### Get IPs

To get a list of IPs that were posted by several different authors, send a `GET` request to `/ips`. The response will be an array of objects with fields: ip and an array of author logins.
