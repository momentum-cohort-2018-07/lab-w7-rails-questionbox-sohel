class Api::V1::CommentsController < Api::V1::BaseController
  skip_before_action :verify_authenticity_token, only: :create

  def new
    render json: {error: "You don't have permission to access these resources"}, status: :unauthorized
    if !(current_user)
    @post = Post.find(params["post_id"])
    @comment = Comment.new

  end
  

  def create
    @post = Post.find(params["post_id"])
    
    user_id = comment_params["comment"]["user_id"]
    reply = comment_params["comment"]["reply"]
    
    @comment = Comment.new(post_id: @post.id, user_id: user_id, body: reply )

    if @comment.save
      render json @comment
    else
      
        render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.permit(:post_id, comment: [:user_id, :reply] )
  end

end