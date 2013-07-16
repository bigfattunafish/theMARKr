class PlacesController < ApplicationController

  def delete
    place_to_delete = User.find(params[:user_id]).places.find(params[:place_id])
    place_to_delete.destroy

    redirect_to user_home_path
  end

end

