class ListsController < ApplicationController

  def create
    if params["list"]["name"].gsub(/\s+/, "").length == 0
      redirect_to "/#{params["list"]["user_id"]}/#{params["list"]["place_id"]}", notice: "Sorry, your list needs to have a name."
    else
      list_to_create = List.create(
        name: params["list"]["name"],
        user_id: params["list"]["user_id"]
      )

      list_to_create.places << Place.find(params["list"]["place_id"])

      redirect_to "/#{params["list"]["user_id"]}/#{params["list"]["place_id"]}",
        notice: "You successfuly created a new favorite list and assigned this place to it!"
    end
  end

  def edit_list
    list_to_update = List.find(params["list_id"])
    list_to_update.update_attributes(params["list"])

    redirect_to "/#{params["user_id"]}/bylist/#{params["list_id"]}",
      notice: "You've successfully updated the list!"
  end


  def delete
    list_to_delete = User.find(params[:user_id]).lists.find(params[:list_id])
    list_to_delete.destroy

    redirect_to user_home_path
  end

end
