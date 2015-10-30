class CreatePrivatePosts < ActiveRecord::Migration
  def change
    create_table :private_posts do |t|
     t.integer :user_id
     t.string  "topic"
     t.text     "text"
     t.integer  "user_id_sent"
     t.datetime "created_at"
     t.datetime "updated_at"
     t.string   "state",       default: "pending_review"
     t.boolean  "notified",    default: false
      t.timestamps null: false
    end
  end
end
