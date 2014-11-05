class AddListingTitleToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :listing_title, :string
  end
end
