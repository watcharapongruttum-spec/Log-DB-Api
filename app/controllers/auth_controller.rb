class AuthController < ActionController::API
  include Auditable

  # POST /login
  def login
    @audit_start_time = Time.current
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = JwtService.encode(user_id: user.id)
      status_code = 200
      message = "User logged in"
      render json: { token: token, user: user.slice(:id, :name, :email, :role) }, status: status_code
    else
      status_code = 401
      message = "Invalid email or password"
      render json: { error: message }, status: status_code
    end

    log_user_action(
      user: user,
      action_type_code: 5, # LOGIN
      summary: message
    )
  end

  # POST /logout
  def logout
    @audit_start_time = Time.current
    status_code = 200
    message = "User logged out"
    render json: { message: message }, status: status_code

    log_user_action(
      user: current_user,
      action_type_code: 6, # LOGOUT
      summary: message
    )
  end
end
