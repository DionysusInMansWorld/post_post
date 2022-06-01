class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :posts, :created_at
    add_index :posts, :updated_at
  end
end
