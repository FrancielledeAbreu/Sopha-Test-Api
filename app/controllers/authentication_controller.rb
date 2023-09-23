class AuthenticationController < ApplicationController
  def register
    @user = User.new(user_params)

    if @user.save
      token = JWT.encode({ user_id: @user.id }, 'your_secret', 'HS256')
      render json: { token: token, user: { id: @user.id, email: @user.email, name: @user.name } }, status: :created
    else
      render json: { error: 'Failed to create user' }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = encode_token({ user_id: user.id })
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password)
  end

  def encode_token(payload)
    JWT.encode(payload, 'your_secret')
  end
end
