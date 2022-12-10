module Api
  module V1
    class IpsController < ApiController
      def index
        ips = Post.group(:ip).having('count(ip) > 1').count.keys.map { |ip| { ip: ip, posts: Post.where(ip: ip).select(:id) } }
        render json: ips, status: :ok
      end
    end
  end
end
