# app/models/action_type.rb
class ActionType < ApplicationRecord
  has_many :audit_logs
end
