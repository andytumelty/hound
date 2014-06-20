class API::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def get_api_token
    user = login(user_params[:email], user_params[:password])
    if user.nil?
      api_unauthorized
    else
      render json: {email: user.email, auth_key: user.auth_token}, status: 200
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end

  rescue_from(ActionController::ParameterMissing) do |parameter_missing_exception|
    error = {}
    error[parameter_missing_exception.param] = ['parameter is required']
    response = { errors: [error] }
    respond_to do |format|
      format.json { render json: response, status: :unprocessable_entity }
    end
  end
end