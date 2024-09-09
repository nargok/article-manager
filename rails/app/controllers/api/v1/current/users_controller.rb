class Api::V1::Current::UsersController < Api::V1::BaseController
  before_action :authenticate_user!

  def show
    render json: CurrentUserSerializer.new(current_user).serialize
  end
end
