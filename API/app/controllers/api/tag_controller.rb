class Api::TagController < ApplicationController
  protect_from_forgery with: :null_session
  respond_to :json, :xml
  before_action :api_authenticate
  
  def index
    @tag = Tag.all.order(created_at: :desc)
      respond_with @tag
   end
  
  def show
    @tag = Tag.find_by_id(params[:id])
    respond_with @tag
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
  
  #HÄR UPDATERAR VI
  def update
    tag = Tag.find(params[:id])
    tag.update(tag_params)
    render json: tag, status: :ok
    rescue ActiveRecord::RecordNotFound
    displayError("We could not find the required Tag. Check the ID!")
    render json: error, status: :not_found
  end
  
  private
  def tag_params
    params.permit(tags: [:category])
  end
  
end
