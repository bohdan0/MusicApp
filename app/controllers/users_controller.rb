class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def show
    if current_user
      @user = current_user
      render :show
    else
      redirect_to new_session_url

    end
  end

  def create
    user = User.new(user_params)
    if user.save
      log_in(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = user.errors.full_messages
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
