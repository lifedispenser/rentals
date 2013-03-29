class WelcomeController < ApplicationController
  def index
    @featured_rentals = Rental.featured
  end
end
