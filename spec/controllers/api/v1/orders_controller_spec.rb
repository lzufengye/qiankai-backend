require 'rails_helper'

RSpec.describe Api::V1::OrdersController do

  let(:consumer) { FactoryGirl.create :consumer, :with_address }
  let(:customer) { FactoryGirl.create :customer, :with_products }

  describe '#create' do
    context 'with a consumer login token' do
      let(:token) { login_as_consumer consumer }

      it 'should create one order with product from one customer' do
        products = customer.products.map { |product| {id: product.id, quantity: 10} }

        expect do
          post :create, format: :json, order: {address_id: consumer.addresses[0].id, products: products}, token: token
        end.to change { Order.count }.by(1)

        expect(response.status).to eq(201)
      end
    end

    context 'without token' do
      it 'should not create order if without token' do
        products = customer.products.map { |product| {id: product.id, quantity: 10} }
        post :create, format: :json, order: {address_id: consumer.addresses[0].id, products: products}
        expect(response.status).to eq(401)
      end
    end
  end

end
