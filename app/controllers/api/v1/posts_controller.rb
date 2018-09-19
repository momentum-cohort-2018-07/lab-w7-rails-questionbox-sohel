class Api::V1::PostsController < Api::V1::BaseController
    before_action :set_post, only: [:destroy]
    skip_before_action :verify_authentication, only: [:index, :show]
    skip_before_action :verify_authenticity_token, only: :create
    
    def index
      @posts=Post.all
      render json: @posts, status: :accepted
    end
  
    def new
      @post=Post.new
    end

    def update
      @post = Post.find(params[:id])
      if  @post.update(post_params)
          render json: @post, status: :accepted
      else
          render json: @post.errors.messages, status: :unprocessable_entity
      end
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
      render json: @post
    end
  
    def destroy
        @post = Post.find(params[:id])
        if  @post.destroy 
            render json: @post, status: :accepted
        else 
            render json: @post.errors.messages, status: :unauthorized
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
