class Api::CommentsController < ApplicationController
  
  
  def new
    redirect_to post_path, notice: 'You must be logged in to comment' if !(current_user)
    @comment = Comment.new 
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to @comment.post, notice: 'Reply successfully created.'
    else
      render :new
  end

  private

  def comment_params
    params.permit(:post_id, :user_id, :body)
  end


end
