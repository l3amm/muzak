require 'open-uri'

namespace :shoppers do 
  desc "gets all the registerd shoppers near the sensor"
  task :get_detected_shoppers => :environment do
    url = "https://store.euclidelements.com/shoppers.json?credential=hackathon&proximity=detected"
    clients = JSON.parse(RestClient.get(url))
    clients.each do |client|
      user = User.find_by_shopper_id(client["id"])
      if user
        p user
        p user.spotify_song
      end
    end
  end
end