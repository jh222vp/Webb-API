class Api::PositionController < ApplicationController
  protect_from_forgery with: :null_session
  respond_to :json, :xml
  before_action :api_authenticate
  
  def index
    @position = Position.all.order(created_at: :desc)
    respond_with @position 
  end
  
  def show
    @position = Position.find_by_id(params[:id])
    respond_with @position
  end
  
  #HÄR UPDATERAR VI
  def update
    position = Tag.find(params[:id])
    position.update(tag_params)
    render json: position, status: :ok
    rescue ActiveRecord::RecordNotFound
    error = ErrorMessage.new("We could not find the required positions. Check the ID!")
    render json: error, status: :not_found
  end
  
  def api_authenticate
      if request.headers["Authorization"].present?
      # Take the last part in The header (ignore Bearer)
      auth_header = request.headers['Authorization'].split(' ').last
        
      key = User.find_by_key(auth_header)
      if !key
      render json: { error: 'The provided token wasn´t correct' }, status: :bad_request
      end
      else
      render json: { error: 'Need to include the Authorization header' }, status: :forbidden # The header isn´t present
      end
   end
  
  private
  def tag_params
    params.permit(:category)
  end
end
