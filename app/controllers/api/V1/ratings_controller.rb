module Api
  module V1
    class RatingsController < ApiController
      def index
        ratings = Rating.all.page(page).per(per_page)
        render json: ratings, status: :ok
      end

      def create
        rating = user.ratings.create!(rating_params)
        render json: rating, status: :created
      end

      private

      def rating_params
        params.require(:rating).permit(:user_id, :post_id, :value)
      end

      def per_page
        params[:per_page] || 10
      end

      def page
        params[:page] || 1
      end

      def user
        @user ||= User.find(rating_params[:user_id])
      end
    end
  end
end
