# frozen_string_literal: true

class SellersController < ApplicationController
  before_action :find_seller, only: %i[show]

  SellerReducer = Rack::Reducer.new(
    User.with_role(:seller),
    ->(page: 1) { page(page) },
    ->(name: ) { by_name(name) }
  )

  def index
    render json: SellerReducer.apply(params)
  end

  def show
    render json: @user
  end

  private

  def find_seller
    @user = User.find(params[:id])
  end
end
