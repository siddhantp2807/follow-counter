class AddReferenceToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_reference :notifications, :ig_user, null: false, foreign_key: true
  end
end
