class SessionsController < ApplicationController

  def sign_up
    # PUTTING THIS HERE INSTEAD OF USERS CONTROLLER BECAUSE DON'T WANT TO SHOW THE NAV BAR..
    @user = User.new
  end


  def new
  end

  def create
  end

  def destroy
  end

end
