module Auditable
  extend ActiveSupport::Concern

  SENSITIVE_KEYS = %w[password password_digest token].freeze

  included do
    # CRUD logging: create/update/destroy
    after_action :log_crud_audit, if: -> { defined?(@auditable_record) && @auditable_record.present? }

    # login/logout จะเรียก log_user_action โดยตรงใน controller
  end

  private

  # =====================
  # CRUD logging
  # =====================
  def log_crud_audit
    start_time = @audit_start_time || Time.current
    duration_ms = ((Time.current - start_time) * 1000).round(2)

    AuditLog.create!(
      user: current_user,
      auditable: @auditable_record,
      action_type_id: crud_action_type_code,
      action: action_name.upcase,
      summary: resource_summary(@auditable_record),
      audited_changes: sanitized_changes(@auditable_record),
      ip: request.remote_ip,
      user_agent: request.user_agent,
      controller_name: controller_name,
      action_method: action_name,
      performed_at: Time.current,
      http_method: request.method,
      status: response.status,
      duration_ms: duration_ms,
      params: sanitized_params,
      request_id: request.request_id
    )
  end

  def crud_action_type_code
    case action_name
    when "create" then 1
    when "update" then 3
    when "destroy" then 4
    else 0
    end
  end

  def sanitized_changes(record)
    attrs = action_name == "update" ? record.saved_changes : record.attributes
    attrs.except(*SENSITIVE_KEYS)
  end

  def resource_summary(record)
    record.attributes.except(*SENSITIVE_KEYS).map { |k, v| "#{k}: #{v}" }.join(", ")
  end

  def sanitized_params
    params.to_unsafe_h.deep_dup.except(*SENSITIVE_KEYS)
  rescue
    {}
  end

  # =====================
  # Login/Logout logging
  # =====================
  def log_user_action(user:, action_type_code:, summary:)
    return unless user

    start_time = @audit_start_time || Time.current
    duration_ms = ((Time.current - start_time) * 1000).round(2)

    AuditLog.create!(
      user: user,
      auditable: nil,
      action_type_id: action_type_code,
      action: action_type_code == 5 ? "LOGIN" : "LOGOUT",
      summary: summary,
      audited_changes: {},
      ip: request.remote_ip,
      user_agent: request.user_agent,
      controller_name: controller_name,
      action_method: action_name,
      performed_at: Time.current,
      http_method: request.method,
      status: response.status,
      duration_ms: duration_ms,
      params: sanitized_params,
      request_id: request.request_id
    )
  end
end
