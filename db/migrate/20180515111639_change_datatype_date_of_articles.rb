class ChangeDatatypeDateOfArticles < ActiveRecord::Migration[5.0]
  def change
    change_column :articles, :date, 'timestamptz using date::timestamptz'
  end
end