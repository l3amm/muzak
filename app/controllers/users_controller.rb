require 'rest_client'
class UsersController < ApplicationController
  respond_to :json, :html
  def index

  end
  def show
    
  end
  
  # POST /users/create
  # -----------------------------------------
  # creates a user
  #
  # parameters:
  # {
  #   email: <string> email of the user [optional]
  #   name: <string> name of the user [optional]
  #   mac_address: <string> mac address of the user
  #   song: <string> spotify song ID for the user    
  # }
  #
  def create
    @user = User.create(params[:user])
    @user.create_euclid_shopper()
    respond_with @user, location: false
  end
end
