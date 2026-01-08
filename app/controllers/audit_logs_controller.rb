class AuditLogsController < ApplicationController
  before_action :set_audit_log, only: %i[ show update destroy ]

  # GET /audit_logs
  def index
    logs = AuditLog.order(created_at: :desc)
    logs = logs.by_user(params[:user_id]) if params[:user_id].present?
    logs = logs.by_auditable_type(params[:auditable_type]) if params[:auditable_type].present?
    logs = logs.by_action_code(params[:action_type]) if params[:action_type].present?

    render json: logs.map { |log|
      filtered_changes = (log.audited_changes || {}).except("password", "password_digest", "token")

      summary = log.summary
      if summary.blank? && filtered_changes.any?
        summary = filtered_changes.map { |k, v| "#{k}: #{v}" }.join(", ")
      end

      {
        id: log.id,
        action: log.action,                     # high-level action
        action_code: log.action_type_id,        # CRUD/LOGIN/LOGOUT
        auditable_type: log.auditable_type,
        auditable_id: log.auditable_id,
        user_name: log.user&.name,
        user_email: log.user&.email,
        summary: summary,
        audited_changes: filtered_changes,
        http_method: log.http_method,
        status: log.status,
        duration_ms: log.duration_ms,
        params: log.params,
        ip: log.ip,
        user_agent: log.user_agent,
        controller_name: log.controller_name,
        action_method: log.action_method,
        request_id: log.request_id,
        performed_at: log.performed_at,
        created_at: log.created_at
      }
    }
  end







  # GET /audit_logs/1
  def show
    render json: @audit_log
  end

  # POST /audit_logs
  def create
    @audit_log = AuditLog.new(audit_log_params)

    if @audit_log.save
      render json: @audit_log, status: :created, location: @audit_log
    else
      render json: @audit_log.errors, status: :unprocessable_content
    end
  end

  # PATCH/PUT /audit_logs/1
  def update
    if @audit_log.update(audit_log_params)
      render json: @audit_log
    else
      render json: @audit_log.errors, status: :unprocessable_content
    end
  end

  # DELETE /audit_logs/1
  def destroy
    @audit_log.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_audit_log
      @audit_log = AuditLog.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def audit_log_params
      params.expect(audit_log: [ :user_id, :auditable_type, :auditable_id, :action, :audited_changes ])
    end
end
