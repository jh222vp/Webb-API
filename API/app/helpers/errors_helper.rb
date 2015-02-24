module ErrorsHelper
  def raise_bad_format
    @error = ErrorMessage.new("The requested format was not supported, try JSON or XML")
    render json: @error, status: :bad_request
  end
  
  def displayError(usr_mess)
    render json: usr_mess, status: :bad_request
  end
  
      
end
