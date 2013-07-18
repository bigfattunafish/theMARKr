class SessionsController < ApplicationController

  def create_user
    @new_user = User.new(params[:user])
    if @new_user.save
      redirect_to user_home_path
    else
      render "sessions/sign_up"
    end
  end

  def sign_up
    # PUTTING THIS HERE INSTEAD OF USERS CONTROLLER BECAUSE DON'T WANT TO SHOW THE NAV BAR..
    @new_user = User.new
  end

  def new
  end

  def create
    # The following returns a user
    user = User.authenticate(params[:email], params[:password])
    if user
      # This is if login worked
      # Stores the user_id in a cookie!!!!!! This is your wristband for the club
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in!!!"
    else
      # This is if login didn't work
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end


  def destroy
  end

end
