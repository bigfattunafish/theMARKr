class UsersController < ApplicationController

  def index
    # RENDER GOOGLE MAP
    @places = User.find(params[:user_id]).places
    @json = @places.to_gmaps4rails do |place, marker|
      marker.infowindow render_to_string(partial: 'gmapinfo', :locals => { :place => place })
    end

    @user = User.find(params[:user_id])
  end

  def search
    @place_to_search = params[:place_name]

    client = Yelp::Client.new
    request = Yelp::V2::Search::Request::Location.new(
      term: @place_to_search,
      city: 'New York',
      consumer_key: ENV['CONSUMER_KEY'],
      consumer_secret: ENV['CONSUMER_SECRET'],
      token: ENV['TOKEN'],
      token_secret: ENV['TOKEN_SECRET']
    )

    @response = client.search(request)
  end

  def save
    user_id = params[:user_id]
    yelp_id = params[:yelp_id]

    if User.find(user_id).places.map { |place| place["yelp_id"] == yelp_id }.include?(true)
      redirect_to user_home_path, notice: "You already have this place saved. Try again."
    else
      client = Yelp::Client.new
      request = Yelp::V2::Business::Request::Id.new(
        yelp_business_id: yelp_id,
        consumer_key: ENV['CONSUMER_KEY'],
        consumer_secret: ENV['CONSUMER_SECRET'],
        token: ENV['TOKEN'],
        token_secret: ENV['TOKEN_SECRET']
      )
      response = client.search(request)

      place_to_save = Place.create(
        is_claimed: response["is_claimed"],
        rating: response["rating"],
        mobile_url: response["mobile_url"],
        rating_img_url: response["rating_img_url"],
        review_count: response["review_count"],
        name: response["name"],
        snippet_image_url: response["snippet_image_url"],
        rating_img_url_small: response["rating_img_url_small"],
        url: response["url"],
        phone: response["phone"],
        snippet_text: response["snippet_text"],
        image_url: response["image_url"],
        categories: response["categories"],
        display_phone: response["display_phone"],
        rating_img_url_large: response["rating_img_url_large"],
        yelp_id: response["id"],
        is_closed: response["is_closed"],
        location: response["location"]
      )

      current_user = User.find(params[:user_id])
      current_user.places << place_to_save

      redirect_to "/#{user_id}/#{place_to_save.id}"
    end
  end

  def show
    user_id = params[:user_id]
    place_id = params[:place_id]

    @place = User.find(user_id).places.find(place_id)
  end

end


