class AddControllerAndActionToAuditLogs < ActiveRecord::Migration[8.1]
  def change
    add_column :audit_logs, :controller_name, :string
    add_column :audit_logs, :action_method, :string
  end
end
