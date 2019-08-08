# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Requests::Create do
  describe '#call' do
    subject { described_class.new.call(input) }

    let(:input) { { params: { buyer: buyer, service: service, text: text } } }

    let(:buyer) { create(:user) }
    let(:service) { create(:service) }
    let(:text) { "what's up" }

    shared_examples 'a success' do
      it { is_expected.to be_success }

      it 'creates & returns new request' do
        expect { subject }.to(change { ServiceRequest.count }.from(0).to(1))

        request = subject.value![:service_request]
        expect(request).to be_kind_of(ServiceRequest)
        expect(request.id).to eq(ServiceRequest.ids.last)
        expect(request.buyer).to eq(buyer)
        expect(request.service).to eq(service)
        expect(request.text).to eq(text)
      end
    end

    it_behaves_like 'a success'

    context 'when coupon promo_code is given' do
      before { input[:promo_code] = coupon.promo_code }

      let(:coupon) { create(:coupon) }

      it_behaves_like 'a success'

      it 'adds coupon to created request' do
        request = subject.value![:service_request]
        expect(request.coupon).to eq(coupon)
      end

      context 'and coupon is expired' do
        let(:coupon) { create(:coupon, expire_at: 1.day.ago) }

        it { is_expected.to be_failure }

        it 'does not create a request' do
          expect { subject }.not_to(change { ServiceRequest.count }.from(0))
        end
      end
    end
  end
end
