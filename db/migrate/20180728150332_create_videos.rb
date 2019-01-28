class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.belongs_to :admin, index: true, foreign_key: true
      t.string :title
      t.string :description
      t.string :producer
      t.date :released
      t.string :video_path
      t.string :poster_path

      t.timestamps
    end
  end
end