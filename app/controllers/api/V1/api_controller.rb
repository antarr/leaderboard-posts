module Api
  module V1
    class ApiController < ApplicationController
      rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

      private

      def record_invalid(error)
        render json: { error: error.message }, status: :unprocessable_entity
      end

      def record_not_found(error)
        render json: { error: error.message }, status: :unprocessable_entity
      end
    end
  end
end
