class ProfilesController < ApplicationController

  def show
    @user = User.find_by(username: params[:username])
    @posts = @user.posts.order('created_at DESC')
  end

  def edit
    @user = User.find_by(username: params[:username])
  end

  def update
    @user = User.find_by(username: params[:username])
    if @user.update(profile_params)
      flash[:success] = "Your profile has been updated."
      redirect_to profile_path(@user.username)
    else
      @user.errors.full_messages
      flash[:error] = @user.errors.full_messages
      render :edit
    end
  end

protected
  def profile_params
    params.require(:user).permit(:avatar, :bio)
  end
end
