class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :vimeo_uid
      t.integer :twitter_uid
      t.integer :github_uid
      t.integer :instagram_uid

      t.timestamps
    end
  end
end
