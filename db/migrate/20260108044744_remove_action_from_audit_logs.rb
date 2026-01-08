class RemoveActionFromAuditLogs < ActiveRecord::Migration[8.1]
  def change
    remove_column :audit_logs, :action, :string
  end
end
