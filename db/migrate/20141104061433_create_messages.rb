class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :listing, index: true
      t.string :to_username
      t.string :from_username
      t.string :message
      t.integer :type
      t.string :viewed

      t.timestamps
    end
  end
end
