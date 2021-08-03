class CreateRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :records do |t|
      t.timestamp :followed_at
      t.timestamp :unfollowed_at
      t.references :ig, null: false
      t.references :follow, null: false

      t.timestamps
    end
    add_foreign_key :records, :ig_users, column: :ig_id
    add_foreign_key :records, :ig_users, column: :follow_id
  end
end
