class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
