class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.bigint :user_id, null: false, foreign_key: true # User who created the post
      t.string :title, null: false # Post title
      t.text :body, null: false # Post body
      t.string :ip, null: false # IP address of the user who created the post
      t.timestamps
    end
  end
end
