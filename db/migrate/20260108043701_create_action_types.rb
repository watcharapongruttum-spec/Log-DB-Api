# db/migrate/xxxxxxxx_create_action_types.rb
class CreateActionTypes < ActiveRecord::Migration[8.1]
  def change
    create_table :action_types do |t|
      t.integer :code, null: false          # 1,2,3,4
      t.string  :name, null: false          # CREATE, READ, UPDATE, DELETE

      t.timestamps
    end

    add_index :action_types, :code, unique: true
    add_index :action_types, :name, unique: true
  end
end
