class SessionsController < ApplicationController
  def new
  end

  def create
    # If the user exists AND the password entered is correct.
    # Save the user id inside the browser cookie. This is how we keep the user 
    # logged in when they navigate around our website.
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      session[:user_id] = user.id
      redirect_to '/'
    else
    # If user's login doesn't work, send them back to the login form.
      redirect_to '/login'
      flash[:notice] = "Wrong email or password. If you don't have an account, please sign up first."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
