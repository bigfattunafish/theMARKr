class UsersController < ApplicationController

  def index
    # RENDER GOOGLE MAP
    @places = User.find(params[:user_id]).places
    @json = @places.to_gmaps4rails do |place, marker|
      marker.infowindow render_to_string(partial: 'gmapinfo', :locals => { :place => place })
    end

    @user = User.find(params[:user_id])
  end

  def by_list
    # RENDER GOOGLE MAP
    @places = User.find(@current_user.id).lists.find(params[:list_id]).places
    @list = List.find(params[:list_id])
    @json = @places.to_gmaps4rails do |place, marker|
      marker.infowindow render_to_string(partial: 'gmapinfo', :locals => { :place => place })
    end
  end


  def search
    @place_to_search = params[:place_name]
    user_zipcode = User.find(@current_user.id).zipcode

    client = Yelp::Client.new
    request = Yelp::V2::Search::Request::Location.new(
      term: @place_to_search,
      zipcode: user_zipcode,
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
      categories_array = response["categories"].flatten.map{ |category| category.downcase.titleize }.uniq.to_sentence(words_connector: ", ", last_word_connector: ", ", two_words_connector: ", ").gsub(" ", "").split(",") unless response["categories"].nil?
      default_tags_display = categories_array.to_s.gsub('"', '').gsub('[', '').gsub(']', '')
      # default_tags_display = categories_array.map { |n| n.to_sym }
      default_initials_tags = Array.new(categories_array)

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
        location: response["location"],
        tags: default_initials_tags,
        tags_display: default_tags_display
      )

      current_user = User.find(params[:user_id])
      current_user.places << place_to_save

      redirect_to "/#{user_id}/#{place_to_save.id}",
        notice: "You've successfully saved this place!"
    end
  end

  def show
    user_id = params[:user_id]
    place_id = params[:place_id]

    @place = User.find(user_id).places.find(place_id)
    @list = List.new #DUMMY NEW LIST IN CASE A USER WANTS TO CREATE A NEW ONE SO THAT INSTANCE VAR IS AVAILABLE
  end

  def assign_to_list
    place_to_be_assigned = Place.find(params[:place_id])
    place_to_be_assigned.update_attributes(params[:place])

    redirect_to show_place_path,
      notice: "You've successfully updated the list assignment of this place!"
  end

  def edit_tags
    place_to_be_updated = Place.find(params[:place_id])
    inputted_tags_display = params[:place][:tags_display]
    new_tags_display = inputted_tags_display.gsub(',', '').split(" ").map { |tag| tag.downcase.titleize }.uniq.to_s.gsub('"', '').gsub('[', '').gsub(']', '')
    new_tags = inputted_tags_display.gsub(',', '').split(" ").map { |tag| tag.downcase.titleize }.uniq

    place = Place.find(params[:place_id])
    place.tags = new_tags
    place.tags_display = new_tags_display
    place.save

    redirect_to show_place_path,
      notice: "You've successfully updated the tags of this place!"
  end

  def about
  end

end