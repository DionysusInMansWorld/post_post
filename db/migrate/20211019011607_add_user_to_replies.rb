class AddUserToReplies < ActiveRecord::Migration[5.1]
  def change
    add_reference :replies, :user, foreign_key: true
    add_index :replies, [:created_at, :user_id]
  end
end
