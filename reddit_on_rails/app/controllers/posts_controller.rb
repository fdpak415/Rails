class PostsController < ApplicationController
  before_action :require_signed_in!, except: [:show]
  before_action :is_author?, only: [:update, :edit]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(sub_params)
    if @post.save
      redirect_to sub_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  private
  def is_author?
    return if Post.find(params[:id]).author == current_user
    render json: "Forbidden", status: :forbidden
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, :user_id, sub_ids: [])
  end
end
