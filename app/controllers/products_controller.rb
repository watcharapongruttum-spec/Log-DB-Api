class ProductsController < ApplicationController
  include Auditable
  before_action :set_product, only: %i[ show update destroy ]

  def index
    @products = Product.all
    render json: @products
  end

  def show
    render json: @product
  end

  def create
    @auditable_record = Product.new(product_params)
    if @auditable_record.save
      render json: @auditable_record, status: :created
    else
      render json: @auditable_record.errors, status: :unprocessable_entity
    end
  end

  def update
    @auditable_record = @product
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @auditable_record = @product
    @product.destroy!
    head :no_content
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :category_id)
  end
end
