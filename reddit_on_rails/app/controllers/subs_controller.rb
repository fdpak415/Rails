class SubsController < ApplicationController

  before_action :require_signed_in!, except: [:show, :index]
  before_action :is_moderator?, only: [:update, :edit]

  def index
    @subs = Sub.all
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def show
    @sub = Sub.find_by_id(params[:id])
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    @sub.update_attributes(sub_params)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  private
  def is_moderator?
    return if Sub.find(params[:id]).moderator == current_user
    render json: "Forbidden", status: :forbidden
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end


end
