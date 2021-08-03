class CreateBots < ActiveRecord::Migration[6.1]
  def change
    create_table :bots do |t|

      t.string :username_ciphertext
      t.string :password_ciphertext
      
      t.timestamps
    end
  end
end
