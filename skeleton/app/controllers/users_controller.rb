class UsersController < ApplicationController
  
  before_action :redirect_if_its_not_you, only: :new
  
  def new 
    @user = User.new 
    render :new 
  
  end 
  
  def create 
    user = User.new(user_params)
    if user
      login(user)
      redirect_to cats_url
    else
      render :new 
    end
  end 

  def user_params 
    params.require(:user).permit(:username, :password)
  end 

  def redirect_if_its_not_you
    redirect_to cats_url unless current_user && current_user.id == params[:id].to_i
  end
  
end 