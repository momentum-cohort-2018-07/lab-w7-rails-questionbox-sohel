class Api::CommentsController < ApplicationController
  
  
  def new
    redirect_to post_path, notice: 'You must be logged in to comment' if !(current_user)
    @post = Post.find(params["post_id"])
    @comment = Comment.new

  end

  def create
    @post = Post.find(params["post_id"])
    
    user_id = comment_params["comment"]["user_id"]
    reply = comment_params["comment"]["reply"]
    
    @comment = Comment.new(post_id: @post.id, user_id: user_id, body: reply )

    if @comment.save
      puts 'comment saved successfully'
      redirect_to api_post_path(@post), notice: 'Reply successfully created.'
    else
      puts 'comment not saved'
      puts @comment.errors.messages
      
      render :new
    end
  end

  private

  def comment_params
    params.permit(:post_id, comment: [:user_id, :reply] )
  end


end
