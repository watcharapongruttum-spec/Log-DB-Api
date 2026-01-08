class AddFieldsToAuditLogs < ActiveRecord::Migration[8.1]
  def change
    add_column :audit_logs, :action, :string
    add_column :audit_logs, :summary, :text
    add_column :audit_logs, :ip, :string
    add_column :audit_logs, :user_agent, :string
    add_column :audit_logs, :request_method, :string
    add_column :audit_logs, :request_path, :string
    add_column :audit_logs, :application_name, :string
    add_column :audit_logs, :performed_at, :datetime
    add_column :audit_logs, :auditable_name, :string
  end
end
