class ProfilesController < ApplicationController

  def show
    @user = User.find_by(username: params[:username])
    @posts = @user.posts.order('created_at DESC')
  end

  def edit
    @user = User.find_by(username: params[:username])
  end

  def update

  end

end
