class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'citext'
    create_table :users do |t|
      t.citext(:login, null: false, index: { unique: true }) # case-insensitive index
      t.timestamps
    end
  end
end
