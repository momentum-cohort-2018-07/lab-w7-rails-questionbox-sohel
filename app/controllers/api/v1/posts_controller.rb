class Api::V1::PostsController < Api::V1::BaseController
    before_action :set_post, only: [:destroy]
    skip_before_action :verify_authentication, only: [:index, :show]
    skip_before_action :verify_authenticity_token, only: :create
    
    def index
      @posts=Post.all
      render json: @posts
    end
  
    def new
      @post=Post.new
    end
  
    def create
      @post = Post.new(post_params)
      
      if @post.save
        render json: @post, status: :created
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  
    def show
      @post = Post.find(params[:id])
      @comments = @post.comments
      render json: @post
    end
  
    def destroy
      if @user == current_user
        @post = Post.find(params:["user_id"])
        @post = @post.find(params:["id"])
        @post.destroy
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
