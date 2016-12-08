class SessionsController < ApplicationController
  def new
    @user = current_user
    render :new
  end

  def create
    user = User.find_by_credentials(session_params[:email], session_params[:password])
    if user
      log_in(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = user.errors.full_messages
      render :new
    end
  end

  def destroy
    log_out
    redirect_to new_session_url
  end

  private
  def session_params
    params.require(:user).permit(:email, :password)
  end
end
