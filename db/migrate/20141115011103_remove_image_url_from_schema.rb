class RemoveImageUrlFromSchema < ActiveRecord::Migration
  def change
  	remove_column :listings, :image_url
  end
end
