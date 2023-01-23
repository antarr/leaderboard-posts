module Api
  module V1
    class PostsController < ApiController
      def index
        posts = Post.all.page(page).per(per_page)
        render json: posts, status: :ok
      end

      def top
        posts = Post.by_average_rating.page(1).per(per_page)
        render json: posts, status: :ok
      end

      def create
        @post = user.posts.create!(post_params.except(:user_login))
        render json: @post, status: :created
      end

      private

      def post_params
        params.require(:post).permit(:title, :body, :ip, :user_login)
      end

      def user
        @user ||= User.find_or_create_by!(login: post_params[:user_login])
      end

      def per_page
        params[:per_page] || 10
      end

      def page
        params[:page] || 1
      end
    end
  end
end
