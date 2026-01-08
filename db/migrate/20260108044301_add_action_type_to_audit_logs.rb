class AddActionTypeToAuditLogs < ActiveRecord::Migration[8.1]
  def change
    add_reference :audit_logs, :action_type, null: false, foreign_key: true
  end
end
