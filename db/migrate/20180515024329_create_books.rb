class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :url
      t.string :title
      t.string :image_url
      t.string :salesdate
      t.integer :itemprice

      t.timestamps
      
      t.index [:title]
    end
  end
end
