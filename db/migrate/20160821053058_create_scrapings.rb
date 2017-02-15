class CreateScrapings < ActiveRecord::Migration[5.0]
  def change
    create_table :scrapings do |t|
	  t.string :item_name
	  t.string :img
	  t.string :src

      t.timestamps null: false
    end
  end
end
