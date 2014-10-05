class CreateAccessoriesWishLists < ActiveRecord::Migration
  def change
    create_table :accessories_wish_lists do |t|

      t.timestamps
    end
  end
end
