class DropImage < ActiveRecord::Migration
  def up
    drop_table :image
  end

  def down
    create_table :image do |t|
      t.string   "mime_type",                                    null: false
    t.string   "filename",     default: "",                    null: false
    t.integer  "image_width"
    t.integer  "image_height"
    t.text     "description"
    t.string   "alt"
    t.integer  "user_id",                                      null: false
    t.date     "upld_date",                                    null: false
    t.time     "upld_time",    default: '2000-01-01 00:00:00', null: false
    t.datetime "updated",                                      null: false
    t.integer  "game_id"
      t.timestamps        
    end
  add_index "image", ["user_id"], name: "user_id", using: :btree
  end
end
