class Api::ApiController < ApplicationController
  respond_to :json, :xml
  before_action :api_authenticate


  def index
      @user = User.all
      respond_with @user 
      end
    
  def show
      @user = User.find_by_id(params[:id])
      respond_with @user
    end
  
   def api_authenticate
      if request.headers["Authorization"].present?
      # Take the last part in The header (ignore Bearer)
      auth_header = request.headers['Authorization'].split(' ').last
        
        #key = User.find_by_key('375600670e508cc1460b8896cb4fd1fd') 
        key = User.find_by_key(auth_header)
      if !key
      render json: { error: 'The provided token wasn´t correct' }, status: :bad_request
      end
      else
      render json: { error: 'Need to include the Authorization header' }, status: :forbidden # The header isn´t present
      end
   end
  
  def create
    @user = User.new(name :params[:name, :password])
    @user.key = SecureRandom.hex
    respond_to do |format|
      if @user.save
        format.json { render json: @user, status: :created }
        format.xml { render xml: @user, status: :created }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.xml { render xml: @user.errors, status: :unprocessable_entity }
      end
    end   
  end
end
