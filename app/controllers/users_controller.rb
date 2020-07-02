class UsersController < ApplicationController
  skip_before_action :require_login, only: [:create,:index]

  def index 
    users = User.all
    if users
      render json: users
     else render json:{status: 500, message: "No users found"}
    end
  end

  def create
    user = User.create(user_params) 
    if user.valid?
        payload = {user_id: user.id}
        token = encode_token(payload)
        puts token
        render json: {user: user, jwt: token}
    else
        render json: {errors: user.errors.full_messages}, status: :not_acceptable
    end
  end

  
  private 

  def user_params
    params.permit(:username, :password)
  end
end
