class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.integer :time_played
      t.datetime :last_updated
      t.text :urls
      t.text :current_url
    end
    
    add_column :users, :track_length, :integer
    add_column :users, :playlist_id, :integer
  end
end
