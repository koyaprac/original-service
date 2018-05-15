class CreateUserArtConnects < ActiveRecord::Migration[5.0]
  def change
    create_table :user_art_connects do |t|
      t.references :user, foreign_key: true
      t.references :article, foreign_key: true
      t.string :type
      t.text :content

      t.timestamps
    end
  end
end
