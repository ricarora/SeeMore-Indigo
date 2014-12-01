class AddCaptionColumn < ActiveRecord::Migration
  def change

    add_column :feed_items, :caption, :text

  end
end
