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
    flashy(@rental)
    @rental.errors.empty? ? (redirect_to action: :index) : (render :new)
  end

  def edit
    @rental = Rental.find(params[:id])
  end

  def update
    @rental = Rental.find(params[:id])
    @rental.update_attributes(post_params)
    flashy(@rental)
    render :edit
  end

  def publish
    @rental = Rental.find(params[:rental_id])
    @rental.publish!
    if @rental.published?
      flash[:success] = 'Published Successfully'
    else
      flash[:error] = 'Could not publish the rental. Check your data and try again.'
    end
    render :edit
  end

  def unpublish
    @rental = Rental.find(params[:rental_id])
    @rental.unpublish!
    if @rental.published?
      flash[:error] = 'Could not un-publish the rental for an unknown reason.'
    else
      flash[:success] = 'Un-Published Successfully'
    end
    render :edit
  end

  
  def destroy
    Rental.find(params[:id]).destroy
    flash[:success] = 'The rental has been deleted'
    redirect_to action: :index
  end

  private
    def post_params
       params.require(:rental).permit(:name, :description, :pet_friendly, :kid_friendly, :bedrooms, :bathrooms, :rate_per_night, :rate_per_week, :rate_per_month, :contact, :base_rate_per_night, :base_rate_per_month, :base_rate_per_week, :published)
    end
end
