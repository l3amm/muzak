require 'open-uri'

namespace :shoppers do 
  desc "gets all the registerd shoppers near the sensor"
  task :get_detected_shoppers => :environment do
    url = "https://store.euclidelements.com/shoppers.json?credential=hackathon&proximity=detected"
    clients = JSON.parse(RestClient.get(url))
    playlist = Playlist.first
    send_to_spotify = false
    clients.each do |client|
      user = User.find_by_shopper_id(client["id"].to_i)
      if user && user.spotify_song
        user.playlist = playlist
        user_url = "https://store.euclidelements.com/purchases.json?credential=hackathon&shopper_id=#{user.shopper_id}"
        p user_url
        weight = JSON.parse(RestClient.get(user_url))
        p weight
        p "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
        user.timer = 0
        user.save
        urls = playlist.urls
        unless urls.include? user.spotify_song
          index = urls.index(playlist.current_url)
          if index == 0
            ins_index = urls.length
          elsif index.nil?
            ins_index = 0
          elsif playlist.current_url.nil?
            ins_index = 0
            playlist.current_url = user.spotify_song
            playlist.save
          else
            ins_index = index - 1 
          end
          playlist.urls.insert ins_index, user.spotify_song
          playlist.save
          send_to_spotify = true
        end
      end
    end
    # update the playlist counts 
    playlist.users.each do |x|
      p x
      p x.timer
      x.timer = 0 if x.timer.nil?
      x.timer += 1
      if x.timer == 10
        p "removing from the playlist"
        p x
        p x.spotify_song
        playlist.urls.delete x.spotify_song
        playlist.save
        x.timer = 0
        x.playlist = nil
        x.save
        send_to_spotify = true
        # remove from playlist
      end
      x.save
    end
    if send_to_spotify
      p "sending to spotify"
      playlist.send_to_spotify
    end
  end
  
  task :push_to_spotify_server => :environment do
    playlist = Playlist.first
    songs = []
    playlist.users.each do |x|
      songs.push x.spotify_song unless songs.include? x.spotify_song
    end
    # track1 = "spotify:track:3Ozk4jSRueNV1s4pukNcHM"
    # playlist_id = "spotify:user:yandavid:playlist:5kgZph1yXFeYPsDng0OKxR"
    # tracks = ["spotify:track:1HDdzNybLH12mlvZqtizwX", "spotify:track:1HDdzNybLH12mlvZqtizwX"].to_json
    # url = "http://10.1.10.75:1337/playlist/#{playlist_id}/patch"
    # resp = RestClient.post(
    #   url,
    #   tracks
    # )
    # p resp
    # p url
    # p "--=-=-=-=-=-=-=-="
  end
end