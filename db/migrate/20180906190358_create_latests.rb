class CreateLatests < ActiveRecord::Migration[5.1]
  def change
    create_table :latests do |t|
      t.integer :media_id
      t.string :title
      t.string :released
      t.string :description
      t.string :media_type
      t.string :media_producer
      t.string :artist_name
      t.string :media_poster
      
      t.timestamps
    end
  end
end
