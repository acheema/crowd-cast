class RemoveAdUrlChangeResolution < ActiveRecord::Migration
  def change
  	remove_column :advertisements, :advertisement_url
  	rename_column :advertisements, :screen_resolution_x, :width
  	rename_column :advertisements, :screen_resolution_y, :height
  end
end
