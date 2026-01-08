class ApiLogsController < ApplicationController
  before_action :set_api_log, only: %i[ show update destroy ]

  # GET /api_logs
  def index
    @api_logs = ApiLog.all

    render json: @api_logs
  end

  # GET /api_logs/1
  def show
    render json: @api_log
  end

  # POST /api_logs
  def create
    @api_log = ApiLog.new(api_log_params)

    if @api_log.save
      render json: @api_log, status: :created, location: @api_log
    else
      render json: @api_log.errors, status: :unprocessable_content
    end
  end

  # PATCH/PUT /api_logs/1
  def update
    if @api_log.update(api_log_params)
      render json: @api_log
    else
      render json: @api_log.errors, status: :unprocessable_content
    end
  end

  # DELETE /api_logs/1
  def destroy
    @api_log.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_log
      @api_log = ApiLog.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def api_log_params
      params.expect(api_log: [ :user_id, :http_method, :path, :status, :ip_address, :params ])
    end
end
