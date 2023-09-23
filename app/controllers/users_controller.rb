class UsersController < AuthenticatedController
  # GET /user
  def show
    render json: {
      id: current_user.id,
      email: current_user.email,
      name: current_user.name
    }
  end

  # GET /user/stores
  def stores
    render json: current_user.stores
  end
end
