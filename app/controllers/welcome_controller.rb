class WelcomeController < ApplicationController
  def index
    @featured_rentals = Rental.published.featured.limit(6).shuffle
    @banner_rentals = Rental.published.banner.limit(6).shuffle
  end
end
