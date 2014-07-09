class Api::BaseController < ApplicationController

  respond_to :json, :xml

  skip_before_filter :verify_authenticity_token

  before_filter :authenticate_from_user_token!
  before_filter :authenticate_user!

  def authenticate_from_user_token!
    token = params[:auth_token]
    user = User.where(authentication_token: token).first

    if user
      sign_in user, store: false
    end
  end

end