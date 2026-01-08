class AuditLog < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :auditable, polymorphic: true, optional: true 
  belongs_to :action_type, optional: true

  # Scopes
  scope :by_user, ->(user_id) { where(user_id: user_id) }
  scope :by_auditable_type, ->(type) { where(auditable_type: type) }
  scope :by_action_code, ->(code) { joins(:action_type).where(action_types: { code: code }) }

  # Delegate helper
  delegate :name, to: :user, prefix: true, allow_nil: true  # log.user_name
  delegate :email, to: :user, prefix: true, allow_nil: true # log.user_email
end
