class StoresController < AuthenticatedController
  include ErrorHandler

  before_action :set_store, only: [:show, :update, :destroy]

  # GET /stores
  def index
    @stores = current_user.stores
    render json: @stores
  end

  # GET /stores/1
  def show
    render json: @store
  end

  # POST /stores
  def create
    @store = current_user.stores.create!(store_params)
    render json: @store, status: :created
  end

  # PATCH/PUT /stores/1
  def update
    @store.update!(store_params)
    render json: @store
  end

  # DELETE /stores/1
  def destroy
    @store.destroy!
    render json: { message: 'Store deleted successfully' }, status: :ok
  end

  private

  def set_store
    @store = current_user.stores.find(params[:id])
  end

  def store_params
    params.require(:store).permit(:name)
  end
end
