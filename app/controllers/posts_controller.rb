class PostsController < ApplicationController
  before_action :set_post, only: [:destroy]
  skip_before_action :verify_authentication
  
  def index
    @posts=Post.page(params[:page])
  end

  def new
    redirect_to root_path, notice: 'You must be logged in to post a question!' if !(current_user)
    @post=Post.new
  end

  def create
    @post = Post.new(post_params)
    
    if @post.save
      redirect_to posts_path (@post)
    else
      render :new 
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def destroy
    if @user == current_user
      @post = Post.find(params:["user_id"])
      @post = @post.find(params:["id"])
      if @post.destroy
      redirect_to user_post_path, notice: 'Question successfully destroyed!'
      end
    end
  end

  private
  def post_params
    params.require(:post).permit(:question, :body, :user_id)
  end

  def set_post
    @post = Post.find(params["post_id"] || params["id"])
  end


end
