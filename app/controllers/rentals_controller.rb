class RentalsController < ApplicationController

  def index
    if params[:pet_friendly]
      @rentals = Rental.published.pet_friendly
    elsif params[:kid_friendly]
      @rentals = Rental.published.kid_friendly
    elsif params[:long_term]
      @rentals = Rental.published.long_term
    else
      @rentals = Rental.published
    end
  end
  
  def show
    @rental = Rental.find(params[:id])
    render nothing: true, status: 404 unless @rental.published
  end
end
