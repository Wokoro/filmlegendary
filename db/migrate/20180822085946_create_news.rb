class CreateNews < ActiveRecord::Migration[5.1]
  def change
    create_table :news do |t|
      t.belongs_to :admin, index: true, foreign_key: true
      t.string :title
      t.string :news_file_url
      t.date :released
      t.string :image_path

      t.timestamps
    end
  end
end
