class UsersController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = sign_up(user_params)

    if @user.valid?
      sign_in(@user)
      redirect_to @user
    else
      redirect_to root_path
    end
  end

  def show
    @user = User.find(current_user.id)
    @categories = @user.current_risks_by_category
    @genome = Genome.where("user_id =?", @user.id).last
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password)
  end
end

