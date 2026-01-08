class CategoriesController < ApplicationController
  include Auditable
  before_action :set_category, only: %i[show update destroy]

  # GET /categories
  def index
    render json: Category.all
  end

  # GET /categories/:id
  def show
    render json: @category
  end

  # POST /categories
  def create
    @auditable_record = Category.new(category_params)
    @auditable_record.save!

    render json: @auditable_record, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors }, status: :unprocessable_entity
  end

  # PATCH/PUT /categories/:id
  def update
    @auditable_record = @category
    @category.update!(category_params)

    render json: @category
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors }, status: :unprocessable_entity
  end

  # DELETE /categories/:id
  def destroy
    @auditable_record = @category
    @category.destroy!

    head :no_content
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
