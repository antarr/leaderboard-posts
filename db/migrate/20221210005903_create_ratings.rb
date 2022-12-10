class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.bigint :post_id, null: false
      t.bigint :user_id, null: false
      t.integer :value, null: false
      t.timestamps
    end

    add_index :ratings, [:post_id, :user_id], unique: true
  end
end
