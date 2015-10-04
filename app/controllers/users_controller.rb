class UsersController < ApplicationController
before_action :signed_in_user, only: [:index, :edit, :update]
before_action :correct_user, only: [:edit, :update]
before_action :admin_user, only: :destroy
  
  def index
    @users = User.all
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)

  	if @user.save
  	  sign_in(@user)
  	  flash[:success] = "Welcome to your profile!"
  	  redirect_to current_user
    else
      render "new"
    end
  end

  def show
  	@user = User.find_by(id: params[:id])
  end

  def edit
  	@user = User.find_by(id: params[:id])
  end

  def update
  	@user = User.find_by(params[:id])
  	if @user.update_attributes(user_params)
  	  flash[:success] = "Profile updated"
  	  redirect_to @user
  	else
  	  flash[:warning] = "Cannot update"
      render "edit"
  	end
  end

  def destroy
  	@user = User.find_by(id: params[:id])
  	@user.destroy
  	flash[:success] = "User deleted."
  	redirect_to users_path
  end

  private 

  def signed_in_user
  	redirect_to signin_url, notice: "Please sign in." unless signed_in?
  end

  def correct_user
  	@user = User.find(params[:id])
  	redirect_to root_url unless current_user?(@user)
  end

  def admin_user
  	redirect_to(root_url) unless current_user.admin?
  end

  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
