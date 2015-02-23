class PositionController < ApplicationController
  respond_to :json, :xml
  
  def index
    
    @user = User.all
    respond_with @user 
  end
end
