class WelcomeController < ApplicationController
  def index
    @featured_rentals = Rental.featured.limit(6).shuffle
    @banner_rentals = Rental.banner.limit(6).shuffle
  end
end
