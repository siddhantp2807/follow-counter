class CreateIgUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :ig_users do |t|
      t.string :name
      t.string :username
      t.string :profile_pic_url

      t.timestamps
    end
  end
end
