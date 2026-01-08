class CreateAuditLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :audit_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :auditable_type
      t.bigint :auditable_id
      t.string :action
      t.jsonb :audited_changes

      t.timestamps
    end
  end
end
