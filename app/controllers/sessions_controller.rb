class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    render :layout => false
  end

  def create
    user = authenticate_session(session_params)
    if sign_in(user)
      redirect_to user
    else
      redirect_to root_path
      # render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end

