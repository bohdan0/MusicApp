class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by_email(session_params[:email])

    if user && user.is_password?(session_params[:password])
      log_in(user)
      redirect_to root_url
    else
      flash.now[:errors] = ["Wrong email or password"]
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
