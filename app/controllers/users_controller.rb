class UsersController < ApplicationController
  skip_before_action :require_login, only: [:create,:index, :show]

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

  def show 
    if current_user

    user = User.find(current_user.id) 
    posts = user.pictures.with_attached_attachment.order(id: :desc)

    render json: posts
else
    render json: {errors: "No user is logged in"}

    end
  end

  
  private 

  def user_params
    params.permit(:username, :password,:email,:bio, :firstname,:lastname)
  end
end
