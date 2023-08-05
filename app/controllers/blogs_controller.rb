class BlogsController < ApplicationController


  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    if @blog.save
      redirect_to blogs_path
    else
      @blogs = Blog.all
      render :new
    end
  end

  def index
    @blogs = Blog.page(params[:page])
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def show
    @blog = Blog.find(params[:id])
    @blog_comment = BlogComment.new
    @comments = @blog.blog_comments.page(params[:page])
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path
  end

  private

  def blog_params
    params.require(:blog).permit(:blog_title, :caption, :image)
  end

end
