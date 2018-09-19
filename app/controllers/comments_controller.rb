class CommentsController < ApplicationController
  
  
  def new
    redirect_to post_path, notice: 'You must be logged in to comment' if !(current_user)
    @post = Post.find(params["post_id"])
    @comment = Comment.new

  end

  def edit
    @post = Post.find(params["post_id"])
    @comment = Comment.find(params[:id])
  end

  def update
    @post = Post.find(params["post_id"])
    @comment= Comment.find(params[:id])
    @comment.post_id = params[:post_id]
    if @comment.user_id === current_user.id
      @comment.update(comment_params2)
      redirect_to post_path(@post), notice: 'Comment edited!'
    end
  end

  

  def create
    @post = Post.find(params["post_id"])
    
    user_id = comment_params["comment"]["user_id"]
    reply = comment_params["comment"]["reply"]
    
    @comment = Comment.new(post_id: @post.id, user_id: user_id, body: reply )

    if @comment.save
      redirect_to post_path(@post), method: :patch, notice: 'Reply successfully created.'
    else
      
      render :new
    end
  end

  def destroy
    @post = Post.find(params["post_id"])
    @comment = Comment.find(params[:id])
    if @comment.user_id === current_user.id
      @comment.destroy
    redirect_to post_path(@post), notice: 'Comment deleted!' 
    else flash[:notice] = "Must be your question to delete"
    end
  end

  private

  def comment_params
    params.permit(:post_id, comment: [:user_id, :reply] )
  end

  def comment_params2
    params.permit(:post_id, :user_id, :body)
    
  end


end
