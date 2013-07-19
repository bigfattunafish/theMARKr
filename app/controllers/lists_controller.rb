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

end
