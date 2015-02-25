class Api::ApiController < ApplicationController
  include ErrorsHelper
  include ApiControllerHelper
  protect_from_forgery with: :null_session
  respond_to :json, :xml
  before_action :api_key, only: [:create, :update, :destroy]
  before_action :api_authenticate, only: [:index, :show, :nearby]

   def index
      @resturant = Resturant.all.order(created_at: :desc)
      if offset_params.present?
        @resturant = Resturant.limit(@limit).offset(@offset).order(created_at: :desc)
      end
      if @resturant.empty?
        displayError("We could not find the required resturant. Check the ID!")
        respond_with displayError, status: :ok
      else
        respond_with @resturant
      end
    end

  def show
    @resturant = Resturant.find_by_id(params[:id])
    respond_with @resturant
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
  
  def create
    resturant = Resturant.new(resturant_params)
    respond_to do |format|
      if resturant.save
        format.json { render json: resturant, status: :created }
        format.xml { render xml: resturant, status: :created }
      else
        format.json { render json: resturant.errors, status: :unprocessable_entity }
        format.xml { render xml: resturant.errors, status: :unprocessable_entity }
      end
    end   
  end

#HÄR UPDATERAR VI
def update
  resturant = Resturant.find(params[:id])
  new_resturant = resturant.update(resturant_params)
  render json: resturant, status: :ok
  rescue ActiveRecord::RecordNotFound
  displayError("We could not find the required resturant. Check the ID!")
end

#HÄR TAR VI BORT
def destroy
  @resturant = Resturant.find(params[:id])
  @resturant.destroy
  render json: 'The resturant was deleted', status: :ok
  rescue ActiveRecord::RecordNotFound
  displayError("We could not find the required resturant. Check the ID!")
  render json: error, status: :not_found
end
  
  # This method is using the geocoder and helps with searching near a specific position
  def nearby
    # Check the parameters
    if params[:long].present? && params[:lat].present?
    # using the parameters and offset/limit
    t = Position.near([params[:latitude].to_f, params[:longitude].to_f], 1000).limit(@limit).offset(@offset)
    respond_with t.map(&:resturant), status: :ok
    
    else
    displayError("We could not find any resources.")
    render json: error, status: :bad_request # just json in this example
    end
  end
  
  ## This is called from a client who wish to authenticate and get a JSON Web Token back
  def api_auth
    creator = Creator.find_by(username: request.headers[:username])
    if creator && creator.authenticate(request.headers[:password])
    render json: { auth_token: encodeJWT(creator) }
    else
    render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end
  
private
  def resturant_params
    params.require(:resturant).permit(:name, :description, tags_attributes:[:category], position_attributes:[:longitude, :latitude])
  end
end
