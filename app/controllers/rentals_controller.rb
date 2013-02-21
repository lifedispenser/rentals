class RentalsController < ApplicationController
  def index
    @rentals = Rental.all
    respond_to do |format|
      format.json { render json: @rentals }
    end
  end
end
