class RenameTypeColumnToArticle < ActiveRecord::Migration[5.0]
  def change
    rename_column :articles, :type, :site_name
  end
end
