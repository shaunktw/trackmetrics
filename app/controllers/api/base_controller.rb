class Api::BaseController < ApplicationController

  respond_to :json, :xml

  skip_before_filter :verify_authenticity_token

  before_filter :cors_preflight_check

  before_filter :authenticate_from_user_token!
  before_filter :authenticate_user!

  before_filter :cors_preflight_check
  after_filter :set_headers

  # around_filter :cors

  # def cors
  #   cors_preflight_check
  #   yield
  #   set_headers
  # end

  def authenticate_from_user_token! 
    token = params[:auth_token]
    user = User.where(authentication_token: token).last
   # logger.info user.inspect
    if user
      sign_in user, store: false
    end
  end

  private 

  # Allows resources to be shared across domains -- cross-origin resource sharing
  def set_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    headers['Access-Control-Max-Age'] = '1728000'
  end

  # A CORS preflight check allows poorly designd and legacy servers to support CORS by executing a sanity check
  # between client and server
  def cors_preflight_check
    if request.method == :options
      raise "elad"
      response.headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'
    end
  end

end