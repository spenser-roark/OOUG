class CreateConsolesWishLists < ActiveRecord::Migration
  def change
    create_table :consoles_wish_lists do |t|

      t.timestamps
    end
  end
end
