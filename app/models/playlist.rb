class Playlist < ActiveRecord::Base
  has_many :users
  serialize :urls, Array
  
  def send_to_spotify
    playlist_id = "spotify:user:yandavid:playlist:5kgZph1yXFeYPsDng0OKxR"
    tracks = self.urls.to_json
    url = "http://ec2-23-20-102-53.compute-1.amazonaws.com:1337/playlist/#{playlist_id}/patch"
    # url = "http://10.1.10.75:1337/playlist/#{playlist_id}/patch"
    resp = RestClient.post(
      url,
      tracks
    )
  end
end
