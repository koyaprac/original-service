class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :url
      t.string :title
      t.string :image_url
      t.string :date
      t.string :type
      
      t.timestamps
      
      t.index [:title, :date, :url, :type]
    end
  end
end
