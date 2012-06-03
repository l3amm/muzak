require 'rest_client'
class UsersController < ApplicationController
  respond_to :json, :html
  def index

  end
  
  def create_transaction
    p params
  end
  
  # GET /users/current_track_url
  # -----------------------------------------
  # sends the current track of the song
  #  current_track_url
  # parameters:
  # {   
  # }
  #
  def current_track_url
    pl = Playlist.first
    pl.current_url = params[:track_url]
    pl.save
    respond_with status: 200
  end
  
  # GET /users/create
  # -----------------------------------------
  # creates a user
  #
  # parameters:
  # {
  # user:
  #   {
  #     email: <string> email of the user [optional]
  #     name: <string> name of the user [optional]
  #     mac_address: <string> mac address of the user
  #     song: <string> spotify song ID for the user    
  #   }
  # }
  #
  def create
    @user = User.find_by_mac_address(params[:mac_address])
    if @user
      current_song = @user.spotify_song
      playlist = Playlist.first
      playlist.urls.delete current_song
      playlist.save
    else
      @user = User.create(params[:mac_address])
    end
    @user.spotify_song = "spotify:track:#{params[:song]}"
    @user.save
    @user.create_euclid_shopper()
    respond_with @user, location: false
  end
end
