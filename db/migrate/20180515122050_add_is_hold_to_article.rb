class AddIsHoldToArticle < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :is_hold, :boolean, :null => false, :default => true 
  end
end
