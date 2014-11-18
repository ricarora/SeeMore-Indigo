class Changeuidtype < ActiveRecord::Migration
  def change
    remove_column :authentications, :uid
    add_column :authentications, :uid, :string
  end
end
