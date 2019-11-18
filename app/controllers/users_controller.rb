class UsersController < ApplicationController
  def index
    @users = User.where(user_params)
    @users = users.joins(:skills).merge(Skill.where(name: params[:skill])) if params[:skill]

    render json: @users
  end

  def show
    @user = User.find(params[:id])

    if stale?(last_modified: @user.updated_at)
      render json: @user
    end
  end

  def create
    user = User.new(user_params)
    if @user.save
      render json: @user, status: :created, location: users_url(@user)
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    User.find(params[:id]).destroy
  end

  private

  def user_params
    params.permit(:global_admin, :receive_marketing, :external_id, :email, :name, :timezone)
  end
end
