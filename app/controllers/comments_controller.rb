class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
        if current_user
            @comment = Comment.new
        else
            redirect_to post_path(@post), alert: "You must be logged in to comment."
        end
  end
  
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to post_path(@comment.post_id)
    else
      render 'new'
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to @comment
    else
      render 'edit'
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to root_path
  end
 
  private
    def comment_params
      params.require(:comment).permit(:post_id, :body, :user_id)
    end
end
