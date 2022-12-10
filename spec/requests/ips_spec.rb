require 'rails_helper'

RSpec.describe 'IPs', type: :request do
  describe 'GET /ips' do
    before do
      ip_list = ['192.168.1.1', '10.0.0.0', '127.0.0.1']
      ip_list.each do |ip|
        2.times { create(:post, ip: ip) }
      end
      create :post, ip: '0.0.0.0'
    end

    it 'does not include unique ips' do
      get '/api/v1/ips'
      ips = JSON.parse(response.body)
      expect(ips.size).to eq(3)
    end
  end
end
