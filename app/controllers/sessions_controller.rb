class SessionsController < ApplicationController
  def new
  end
#User session creation
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = 'Invalid email/password combination'
    render 'new'
      end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  #User session with gmail-not working currently
  def creater
    auth = request.env["omniauth.auth"]
    session[:omniauth]=auth.except('extra')
    user= User.sign_in_from_omniauth(auth)
    sessioon[:user_id]=user.id
    log_in user
    redirect_back_or user
  end

  def destroy2
    session[:user_id] = nil
    redirect_to root_url
  end

end
