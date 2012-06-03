class User < ActiveRecord::Base
  belongs_to :playlist
  
  def create_euclid_shopper
    url = "https://store.euclidelements.com/shoppers.json?credential=hackathon"
    resp = RestClient.post(
      url,
      {
        mac: self.mac_address,
        name: self.name
      }
    )
    shopper_id = JSON.parse(resp)["shopper_id"]
    self.shopper_id = shopper_id
    self.save
  end
end
