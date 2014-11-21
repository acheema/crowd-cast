class CreateJoinTableAdvertiserListing < ActiveRecord::Migration
  def change
    create_join_table :advertisers, :listings do |t|
      # t.index [:advertiser_id, :listing_id]
      # t.index [:listing_id, :advertiser_id]
    end
  end
end
