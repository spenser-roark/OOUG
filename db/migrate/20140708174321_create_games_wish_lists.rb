class CreateGamesWishLists < ActiveRecord::Migration
  def change
    create_table :games_wish_lists do |t|

      t.timestamps
    end
  end
end
