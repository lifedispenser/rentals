class MrRogers::PhotosController < MrRogers::ApplicationController
  respond_to :json

  def index
    @photos = Photo.all
    render json: @photos.map{|photo| photo.to_jq_photo }
  end

  def show
    @photo = Photo.find(params[:id])
    render json: @photo
  end

  def new
    @photo = Photo.new
    render json: @photo
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def create
    @photo = Photo.new(post_params)
    if @photo.save
      render json: {files: [@photo.to_jq_photo]}, status: :created, location: [:mr_rogers, @photo]
    else
      render json: @photo.errors, status: :unprocessable_entity
    end
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(params[:photo])
      head :no_content
    else
      render json: @photo.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    head :no_content
  end
  
  private
    def post_params
      raw_parameters = { photo: { rental_id: params[:photo][:rental_id], asset: params[:photo][:asset].first } }
      parameters = ActionController::Parameters.new(raw_parameters)
      parameters.require(:photo).permit(:rental_id, :asset)
    end
  
end