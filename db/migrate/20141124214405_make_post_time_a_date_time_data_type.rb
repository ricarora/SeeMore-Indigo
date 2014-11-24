class MakePostTimeADateTimeDataType < ActiveRecord::Migration
  def change
    remove_column :feed_items, :post_time
    add_column :feed_items, :post_time, :datetime
  end
end
