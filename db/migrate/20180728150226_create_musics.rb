class CreateMusics < ActiveRecord::Migration[5.1]
  def change
    create_table :musics do |t|
      t.belongs_to :artist, index: true, foreign_key: true, null: true
      t.belongs_to :admin, index: true, foreign_key: true, null: true
      t.string :title
      t.string :artist_name, index: true, null: false
      t.string :album_title
      t.string :description
      t.string :genre
      t.string :composer
      t.string :producer
      t.date :released
      t.integer :download_count
      t.string :poster_path
      t.string :music_path

      t.timestamps
    end
  end
end
