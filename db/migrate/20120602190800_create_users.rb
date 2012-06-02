class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :mac_address
      t.text :spotify_song
      t.text :email
      t.integer :priority
      t.text :name
      t.timestamps
    end
  end
end
