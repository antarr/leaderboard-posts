module Api
  module V1
    class ApiController < ApplicationController
      rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

      private

      def record_invalid(error)
        render json: { error: error.message }, status: :unprocessable_entity
      end
    end
  end
end
