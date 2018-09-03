class PostsController < ApplicationController
  

  def index
    @posts = Post.all
    @posts = @posts.sort_by(&:cached_votes_total).reverse
    
  end

  def show
    @post = Post.find(params[:id])
  end
 
  def new
    if current_user
      @post = Post.new
    else
      flash[:notice] ="You must be logged to make a new post."
      redirect_to new_session_path
    end
  end

  def edit
    @post = Post.find(params[:id])
    if current_user
      if current_user.id == @post.user_id
          @post = Post.find(params[:id])
      else
          flash[:notice] = 'Only post creator can edit.'
          redirect_to @post 
      end
    else
      flash[:notice] ="You must be logged to edit a post."
      redirect_to new_session_path
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
      flash[:notice] = 'Only users can vote, Please login'
      redirect_to @post
    end
  end

  def destroy 
    @post = Post.find(params[:id])
    if current_user.id == @post.user_id
      @post.destroy
      redirect_to posts_path
    else
      flash[:notice] = 'Only post creator can delete.'
      redirect_to @post
    end
  end
 
  

  private
    def post_params
       params.require(:post).permit(:title, :body, :user_id, :vote)
    end
end
