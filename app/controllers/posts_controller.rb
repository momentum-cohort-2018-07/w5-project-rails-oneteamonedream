class PostsController < ApplicationController
  

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end
 
  def new
    if current_user
      @post = Post.new
    else
      redirect_to new_login_path, alert: "Please log in first."
    end
  end

  def edit
    @post = Post.find(params[:id])
    if current_user
      if current_user.id == @post.user_id
          @post = Post.find(params[:id])
      else
          redirect_to @post, notice: 'Only post creator can edit.'
      end
    else
      redirect_to new_login_path, alert: "Please log in first."
  end
  end

  def create
    @post = Post.new(post_params)
   
    if @post.save
       redirect_to @post
    else
        render 'new'
    end
  end  

  def update
    @post = Post.find(params[:id])
   
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end
  
  def vote
    @post = Post.find(params[:id])  
    respond_to :js, :html
    if current_user   
      if !current_user.liked? @post
        @post.liked_by current_user
        redirect_to @post
      elsif current_user.liked? @post
        @post.unliked_by current_user
        redirect_to @post
       end
    else
      redirect_to new_login_path, alert: "Please log in first."
    end
  end

  def destroy 
    @post = Post.find(params[:id])
    if current_user.id == @post.user_id
      @post.destroy
      redirect_to posts_path
    else
      redirect_to @post, alert: 'Only post creator can delete.'
    end
  end
 
  

  private
    def post_params
       params.require(:post).permit(:title, :body, :user_id, :vote)
    end
end
