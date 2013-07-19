class SessionsController < ApplicationController

  def create_user
    @new_user = User.new(params[:user])
    if @new_user.save
      logged_in_user = User.authenticate(params[:user][:email], params[:user][:password])
      session[:user_id] = logged_in_user.id
      redirect_to "/#{@new_user.id}"
    else
      render "sign_up"
    end
  end

  def sign_up
    # PUTTING THIS HERE INSTEAD OF USERS CONTROLLER BECAUSE DON'T WANT TO SHOW THE NAV BAR..
    @new_user = User.new
  end

  def new
  end

  def create
    logged_in_user = User.authenticate(params[:email], params[:password])
    if logged_in_user
      session[:user_id] = logged_in_user.id
      redirect_to loading_path
    else
      # This is if login didn't work
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def loading
    sleep(1)
    redirect_to "/#{@current_user.id}", notice: "Wecome back, #{@current_user.username}!"
  end


  def destroy
    session[:user_id] = nil
    redirect_to goodbye_path
  end

  def goodbye
  end
end
