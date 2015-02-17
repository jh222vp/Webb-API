class UsersController < ApplicationController  
 
    before_action :check_user, only: [:show, :destroy]
    before_action :correct_user, only: [:show]
  
  def index
    
  end
  
  def show
    @user = User.find(params[:id])
    @users = User.all
  end
  
 def new
  @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    @user.key = SecureRandom.hex
    if @user.save
      flash[:success] = "Welcome to Webbteknik2!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  #Destorys the API key
  def destroy
    @user = User.find(params[:id])
    @user.update_attribute(:key, nil)
    redirect_to @user
  end
  
  #Generates a new API key
  def generate_API
    @user = User.find(params[:id])
    
    if  @user.update_attribute(:key, SecureRandom.hex) 
      redirect_to @user
    else
      flash.now[:danger] = 'Du har redan en API Nyckel' # Not quite right!
    end
  end
  
  def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
  end
  
  def edit
    @user = User.find(params[:id])
  end
 
  
  private
  def correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless @user == current_user
  end
  
end
