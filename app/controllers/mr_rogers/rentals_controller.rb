class MrRogers::RentalsController < MrRogers::ApplicationController
  respond_to :html
  
  def index
    respond_to do |format|
      format.html
      format.json { render json: RentalsDatatable.new(view_context) }
    end
  end
  
  def new
    @rental = Rental.new
  end
  
  def create
    @rental = Rental.create(post_params)
    flashy
    @rental.errors.empty? ? (redirect_to action: :index) : (render :new)
  end

  def edit
    @rental = Rental.find(params[:id])
  end

  def update
    @rental = Rental.find(params[:id])
    @rental.update_attributes(post_params)
    flashy
    render :edit
  end
  
  def destroy
    Rental.find(params[:id]).destroy
    flash[:success] = 'The rental has been deleted'
    redirect_to action: :index
  end

  private
    def post_params
       params.require(:rental).permit(:name, :description, :pet_friendly, :kid_friendly, :bedrooms, :bathrooms, :rate_per_night, :rate_per_week, :rate_per_month, :contact, :base_rate_per_night, :base_rate_per_month, :base_rate_per_week)
    end
    
    def flashy
      if @rental.errors.empty?
        flash.now[:success] = 'Saved successfully'
      else
        flash.now[:error] = 'There was an error saving'
      end
    end
end
