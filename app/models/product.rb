class Product < ApplicationRecord
  belongs_to :category
  has_many :audit_logs, as: :auditable
end
