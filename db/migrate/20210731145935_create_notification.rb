class CreateNotification < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.string :title
      t.string :message
      t.string :profile_pic_url

      t.timestamps
    end
  end
end
