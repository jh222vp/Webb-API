class Api::CreatorController < ApplicationController
  include ErrorsHelper
  include ApiControllerHelper
  protect_from_forgery with: :null_session
  respond_to :json, :xml
  
  before_action :api_key, only: [:create, :update, :destroy]
  before_action :api_authenticate, only: [:index, :show, :nearby]
  
  def index
    @creator = Creator.all.order(created_at: :desc)
      if offset_params.present?
        @creator = Creator.limit(@limit).offset(@offset).order(created_at: :desc)
      end
      if @creator.empty?
        displayError("We could not find the required creator. Check the ID!")
        respond_with displayError, status: :ok
      else
        respond_with @creator
      end
    end

  def show
    @creator = Creator.find_by_id(params[:id])
    respond_with @creator
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
  
end
