class EmployeesController < ApplicationController
  include Auditable
  before_action :set_employee, only: %i[show update destroy]

  # GET /employees
  def index
    render json: Employee.all
  end

  # GET /employees/:id
  def show
    render json: @employee
  end

  # POST /employees
  def create
    @auditable_record = Employee.new(employee_params)
    @auditable_record.save!

    render json: @auditable_record, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors }, status: :unprocessable_entity
  end

  # PATCH/PUT /employees/:id
  def update
    @auditable_record = @employee
    @employee.update!(employee_params)

    render json: @employee
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors }, status: :unprocessable_entity
  end

  # DELETE /employees/:id
  def destroy
    @auditable_record = @employee
    @employee.destroy!

    head :no_content
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(
      :name,
      :position
    )
  end
end
