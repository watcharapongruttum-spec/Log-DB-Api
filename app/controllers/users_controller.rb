class UsersController < ApplicationController
  include Auditable
  before_action :set_user, only: %i[show update destroy]

  # GET /users
  def index
    render json: User.all
  end

  # GET /users/:id
  def show
    render json: @user
  end

  # POST /users
  def create
    @auditable_record = User.new(user_params)
    @auditable_record.save!

    render json: @auditable_record, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors }, status: :unprocessable_entity
  end

  # PATCH/PUT /users/:id
  def update
    @auditable_record = @user

    @user.update!(user_params)
    render json: @user
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors }, status: :unprocessable_entity
  end

  # DELETE /users/:id
  def destroy
    @auditable_record = @user
    @user.destroy!

    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :role
    )
  end
end
