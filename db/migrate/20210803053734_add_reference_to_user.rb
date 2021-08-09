class AddReferenceToUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :ig_user, foreign_key: true
  end
end
