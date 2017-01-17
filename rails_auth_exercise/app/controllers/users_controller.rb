class UsersController < ApplicationController
  def create
    @user = User.new(params[:user])

    if @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      render json: @user.errors.full_messages
    end
  end

  before_action :require_current_user!, except: [:create, :new]
end
