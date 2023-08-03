class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @blog = Blog.find(params[:blog_id])
    like = current_user.likes.new(blog_id: @blog.id)
    like.save
    # redirect_to request.referer
  end

  def destroy
    @blog = Blog.find(params[:blog_id])
    like = current_user.likes.find_by(blog_id: @blog.id)
    like.destroy
    # redirect_to request.referer
  end

end
