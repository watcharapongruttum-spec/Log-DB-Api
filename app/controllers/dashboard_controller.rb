# app/controllers/dashboard_controller.rb
class DashboardController < ApplicationController
  # GET /dashboard
  def index
    result = {
      users_count: User.count,
      products_count: Product.count,
      categories_count: Category.count,
      employees_count: Employee.count,
      audit_logs_count: AuditLog.count,
      api_logs_count: ApiLog.count
    }

    render json: result
  end
end
