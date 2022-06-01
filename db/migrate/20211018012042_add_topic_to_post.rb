class AddTopicToPost < ActiveRecord::Migration[5.1]
  def change
    add_reference :posts, :topic, foreign_key: true
    add_index :posts, [:topic_id, :updated_at]
  end
end
