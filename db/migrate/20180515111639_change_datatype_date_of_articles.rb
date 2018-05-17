class ChangeDatatypeDateOfArticles < ActiveRecord::Migration[5.0]
  def change
    #https://stackoverflow.com/questions/31727203/rails-migration-to-postgres-issue-time
    change_column :articles, :date, 'timestamptz using date::timestamptz'
  end
end