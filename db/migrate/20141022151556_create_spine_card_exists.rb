class CreateSpineCardExists < ActiveRecord::Migration
  def change
    create_table :spine_card_exists do |t|

      t.timestamps
    end
  end
end
