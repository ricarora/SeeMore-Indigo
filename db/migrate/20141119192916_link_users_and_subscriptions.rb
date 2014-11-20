class LinkUsersAndSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions_users, id: false do |t|
      t.belongs_to :subscription
      t.belongs_to :user
    end
  end
end
