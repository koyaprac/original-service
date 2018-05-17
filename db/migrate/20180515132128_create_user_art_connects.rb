class CreateUserArtConnects < ActiveRecord::Migration[5.0]
  def change
    create_table :user_art_connects do |t|
      t.references :user, foreign_key: true
      t.references :article, foreign_key: true
      t.string :type
      t.text :content

      t.timestamps
      t.index [:user_id, :article_id , :type], unique: true
    end
  end
end
