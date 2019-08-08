# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation/dsl'
require 'faker'

resource 'Service Requests' do
  explanation 'Service requests resource'

  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  let(:current_user) { create(:buyer) }
  before do
    if current_user
      header 'Authorization', "Bearer #{Knock::AuthToken.new(payload: { sub: current_user.id }).token}"
    end
  end

  get '/service_requests/:id' do
    let(:service_request) { create(:service_request, buyer: current_user) }
    let(:id) { service_request.id }

    example_request 'Getting require service request data' do
      expect(status).to eq(200)
    end
  end

  post '/service_requests' do
    with_options scope: :service_request, with_example: true do
      parameter :text, 'Message from buyer about service', required: true
      parameter :service_id, 'ID of ordered service', required:true
      parameter :video, 'Some attached video'
      parameter :promo_code, 'Promo code which make some discount'
    end

    let!(:coupon) { create(:coupon) }
    let!(:service) { create(:service) }

    let(:text) { 'text' }
    let(:promo_code) { coupon.promo_code }
    let(:service_id) { service.id }

    let(:raw_post) { params.to_json }

    example_request 'Add new service request' do
      expect(status).to eq(200)
    end
  end

  patch '/service_requests/:id/submit' do
    let(:service_request) { create(:service_request, buyer: current_user) }
    let(:id) { service_request.id }

    let(:raw_post) { params.to_json }

    example_request 'Submit service request' do
      expect(status).to eq(200)
    end
  end
end
