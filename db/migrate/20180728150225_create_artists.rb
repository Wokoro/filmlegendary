class CreateArtists < ActiveRecord::Migration[5.1]
  def change
    create_table :artists do |t|
      t.string :name
      t.integer :sex
      t.string :email
      t.string :phone_number
      t.string :image_path
      t.text :biography

      t.timestamps
    end
  end
end
