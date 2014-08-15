class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      flash[:success] = "thanks for signing up"
  	 redirect_to root_path
    else
      flash[:error] = "Ooops, try again"
      render :new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = "Your user was updated"
      redirect_to user_path(@user)
    else
      flash[:error] = "Oops somethinig went wrong"
      render :edit
    end
  end

  private
  def user_params
  	params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
