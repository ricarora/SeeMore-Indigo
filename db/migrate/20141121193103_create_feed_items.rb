class CreateFeedItems < ActiveRecord::Migration
  def change
    create_table :feed_items do |t|
      t.text :content
      t.integer :subscription_id
      t.string :post_time

      t.timestamps
    end
  end
end
