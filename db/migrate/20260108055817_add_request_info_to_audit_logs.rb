class AddRequestInfoToAuditLogs < ActiveRecord::Migration[8.1]
  def change
    add_column :audit_logs, :http_method, :string
    add_column :audit_logs, :status, :integer
    add_column :audit_logs, :duration_ms, :float
    add_column :audit_logs, :params, :jsonb
    add_column :audit_logs, :request_id, :string
  end
end
