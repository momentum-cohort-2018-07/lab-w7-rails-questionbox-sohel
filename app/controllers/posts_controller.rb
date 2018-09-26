class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]
  skip_before_action :verify_authentication
  
  def index
    @posts=Post.page(params[:page])
  end

  def new
    redirect_to root_path, flash[:notice] = 'You must be logged in to post a question!' if !(current_user)
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
    if @post.user_id == current_user.id
      @post.destroy
      redirect_to root_path
    else
      redirect_to root_path
      flash[:notice] = "Must be your question to delete"
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
