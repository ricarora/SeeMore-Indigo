class Changeusertable < ActiveRecord::Migration
  def change
    remove_column :users, :vimeo_uid
    remove_column :users, :twitter_uid
    remove_column :users, :github_uid
    remove_column :users, :instagram_uid
  end
end
