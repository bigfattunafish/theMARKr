class UsersController < ApplicationController

  def index
    # RENDER GOOGLE MAP
    @places = Place.all
    @json = @places.to_gmaps4rails

    @user = User.find(params[:user_id])
  end

  def search
    place_to_search = params[:place_name]

    client = Yelp::Client.new
    request = Yelp::V2::Search::Request::Location.new(
      :term => place_to_search,
      :city => 'New York',
      # :consumer_key => ENV['CONSUMER_KEY'],
      # :consumer_secret => ENV['CONSUMER_SECRET'],
      # :token => ENV['TOKEN'],
      # :token_secret => ENV['TOKEN_SECRET'])
      :consumer_key => '87kx427n0xwNI0ZYZC8Mbw',
      :consumer_secret => 'kuIIbMgTmuf42cBV3rT9x_2BCfk',
      :token => 'Z4pVQzhUxAi4xfelEtPY2wndHE2NC9Bo',
      :token_secret => 'xqLB1z3tZu3kjKCnIfI61PyO2Qg')

    @response = client.search(request)
  end


end


# client = Yelp::Client.new
# request = Yelp::V2::Search::Request::Location.new(
#   :term => place_to_search,
#   :city => 'New York',
#   :consumer_key => '87kx427n0xwNI0ZYZC8Mbw',
#   :consumer_secret => 'kuIIbMgTmuf42cBV3rT9x_2BCfk',
#   :token => 'Z4pVQzhUxAi4xfelEtPY2wndHE2NC9Bo',
#   :token_secret => 'xqLB1z3tZu3kjKCnIfI61PyO2Qg')