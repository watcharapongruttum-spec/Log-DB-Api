class ApplicationController < ActionController::API
  before_action :authenticate_user!

  attr_reader :current_user

  def authenticate_user!
    header = request.headers["Authorization"]
    return render json: { error: "Unauthorized" }, status: 401 if header.blank?

    token = header.split(" ").last
    payload = JwtService.decode(token)

    @current_user = User.find(payload["user_id"])
  rescue
    render json: { error: "Invalid token" }, status: 401
  end
end
