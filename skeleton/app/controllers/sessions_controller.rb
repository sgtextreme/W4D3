class SessionsController < ApplicationController
  
  before_action :redirect_if_its_not_you, only: :new
  
  def new
    render :new 
  end   
    
  def destroy 
    if current_user
      current_user.reset_session_token!
      @current_user = nil
      session[:session_token] = nil
    end
    redirect_to new_session_url
  end 
  
  def create 
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    if user
      login(user)
      redirect_to cats_url
    else
      render :new
    end
  end 
  
  def redirect_if_its_not_you
    redirect_to cats_url unless current_user && current_user.id == params[:id].to_i
  end
  
end
