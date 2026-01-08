require "test_helper"

class AuditLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @audit_log = audit_logs(:one)
  end

  test "should get index" do
    get audit_logs_url, as: :json
    assert_response :success
  end

  test "should create audit_log" do
    assert_difference("AuditLog.count") do
      post audit_logs_url, params: { audit_log: { action: @audit_log.action, auditable_id: @audit_log.auditable_id, auditable_type: @audit_log.auditable_type, audited_changes: @audit_log.audited_changes, user_id: @audit_log.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show audit_log" do
    get audit_log_url(@audit_log), as: :json
    assert_response :success
  end

  test "should update audit_log" do
    patch audit_log_url(@audit_log), params: { audit_log: { action: @audit_log.action, auditable_id: @audit_log.auditable_id, auditable_type: @audit_log.auditable_type, audited_changes: @audit_log.audited_changes, user_id: @audit_log.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy audit_log" do
    assert_difference("AuditLog.count", -1) do
      delete audit_log_url(@audit_log), as: :json
    end

    assert_response :no_content
  end
end
