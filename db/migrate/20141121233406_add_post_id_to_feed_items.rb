class AddPostIdToFeedItems < ActiveRecord::Migration
  def change
    add_column :feed_items, :post_id, :string
  end
end
