class RentalsController < ApplicationController
  def index
    @rentals = Rental.all
  end
  
  def show
    @rental = Rental.find(params[:id])
  end
end
