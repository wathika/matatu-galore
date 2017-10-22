class PostsController < ApplicationController
  def index
    @posts = Post.all()

  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)

    if @post.save
      redirect_to posts_path
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to post_path(@post)
    end
  end

  def delete
  end

  private
    def post_params
      params.require(:post).permit(:image, :caption)
    end
end
