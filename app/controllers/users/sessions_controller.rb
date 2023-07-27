class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(_resource, _opts = {})
    render json: { message: 'Logged in sucessfully.', user: current_user }, status: :ok
  end

  def respond_to_on_destroy
    log_out_success && return if current_user # this means if the user is logged in, then log them out

    log_out_failure
  end

  def log_out_success
    render json: { message: 'Logged out sucessfully.' }, status: :ok
  end

  def log_out_failure
    render json: { message: 'Something went wrong.' }, status: :unauthorized
  end
end
