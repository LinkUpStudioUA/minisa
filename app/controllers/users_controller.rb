# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user, except: %i[create index]

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    render json: current_user
  end

  def update
    if current_user.update(user_params)
      head :ok
    else
      render json: current_user.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :password, :role, :location, :email, :avatar
    )
  end
end
