class AddAvatarUsernameDisplayNameToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :avatar_url, :text
    add_column :subscriptions, :username, :string
    add_column :subscriptions, :display_name, :string
  end
end
