class UsersController < ApplicationController
  def index
    users = User.where(user_params)
    users = users.joins(:skills).merge(Skill.where(name: params[:skill])) if params[:skill]

    render json: users
  end

  private

  def user_params
    params.permit(:global_admin, :receive_marketing, :external_id)
  end
end
