class HomeController < ApplicationController

  def index
    @places = Place.all
    @json = @places.to_gmaps4rails
  end

end
