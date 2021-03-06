class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :redirect_if_user_not_current_user

  def show
    @user = User.find(params[:id])
  end

  def is_user_current_user?
    if user_signed_in?
      @user = User.find(params[:id])
      return user_signed_in? && @user.id == current_user.id
    else
      return false
    end
  end

  def redirect_if_user_not_current_user
    if !is_user_current_user?
      flash[:error] = "Tu n'as pas l'autisation de gérer ce profil."
      redirect_to root_path
    end
  end

end
