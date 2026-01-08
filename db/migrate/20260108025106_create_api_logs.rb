class CreateApiLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :api_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :http_method
      t.string :path
      t.integer :status
      t.string :ip_address
      t.jsonb :params

      t.timestamps
    end
  end
end
