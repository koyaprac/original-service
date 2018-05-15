class CreateUserArtConnect < ActiveRecord::Migration[5.0]
  def change
    create_table :user_art_connect do |t|
      t.references :user
      t.references :article
      t.string :type
      t.text :content

      t.timestamps
      t.index [:user_id, :article_id , :type], unique: true
    end
  end
end
