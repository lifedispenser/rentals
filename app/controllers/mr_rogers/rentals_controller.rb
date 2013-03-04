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
    redirect_to action: :index
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

  private
    def post_params
       params.require(:rental).permit(:name, :description)
    end
    
    def flashy
      if @rental.errors.empty?
        flash[:success] = 'Saved successfully'
      else
        flash[:error] = 'There was an error saving'
      end
    end
end
