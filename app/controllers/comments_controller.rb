class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
        if current_user
            @comment = Comment.new
        else
            flash[:notice] ="You must be logged in to comment."
            redirect_to new_session_path
        end
  end
  
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to post_path(@comment.post.id)
    else
      redirect_to post_path(@comment.post.id)
      flash[:comment] ="Comment can't be blank."
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    if current_user.id == @comment.user_id
      @post = Post.find(params[:post_id])
    else
      redirect_to post_path(@comment.post_id), alert: 'Only comment creator can edit.'
    end
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
    @id = @comment.post_id
    if current_user.id == @comment.user_id
        @comment.destroy
        redirect_to post_path(@id)
    else
        redirect_to post_path(@id), alert: 'Only comment creator can delete.'
    end
  end
 
  private
    def comment_params
      params.require(:comment).permit(:post_id, :body, :user_id)
    end
end
