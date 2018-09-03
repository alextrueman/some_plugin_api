class Api::V1::UsersController < Api::ApplicationController
  skip_before_action :authenticate!, only: [:create]

  def create
    user = User.new(user_params)
    if user.save
      render json: user, serializer: UserSerializer, status: 200
    else
      render json: user.errors, status: 500
    end
  end

  private

  def user_params
    params.require(:user).permit(:browser_name)
  end
end
