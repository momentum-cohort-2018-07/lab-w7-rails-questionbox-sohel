class Api::PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]
  skip_before_action :verify_authentication
  
  def index
    @posts=Post.all
  end

  def new
    redirect_to api_root_path, notice: 'You must be logged in to post a question!' if !(current_user)
    @post=Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post
    else
      render :new 
    end
  end

  def show
    redirect_to api_user_post_path
  end

  def destroy
    if user == current_user
      @post = Post.find(params:["user_id"])
      @post = @post.find(params:["id"])
      if @post.destroy
      redirect_to api_user_post_path, notice: 'Question successfully destroyed!'
      end
    end
  end

  private
  def post_params
    params.require(:question).permit(:body, :user_id)
  end


end
