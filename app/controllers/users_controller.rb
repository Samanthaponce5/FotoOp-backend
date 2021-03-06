class UsersController < ApplicationController
  skip_before_action :require_login, only: [:create,:index, :show,:update, :showVisit, :followees, :followers]

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
      comments=[]
    user.pictures.each do |post|
      comments << post.comments
  end
    
    followees = User.find(current_user.id).followees
    followers=User.find(current_user.id).followers
    render json: {posts:posts,comments:comments, user:user,followees:followees, followers:followers}
else
    render json: {errors: "No user is logged in"}

    end
  end

  def showVisit
    user =  User.find(params[:id])
    posts = user.pictures.with_attached_attachment.order(id: :desc)
    
    followees = User.find(params[:id]).followees
    followers=User.find(params[:id]).followers
    render json: {posts:posts, user:user,followees:followees, followers:followers}

  end

  def update
    # byebug
    user = User.find(params[:id])
    if  user.update(user_params)
    render json: {user:user}
    end
    # user = User.find(params[:id])
    # user.update(avatar:params[:avatar])
    # avatar_url = rails_blob_path(user.avatar)
    # render json: {user:user, avatar_url:avatar_url}
  end


  
  private 

  def user_params
    params.permit(:username, :password,:email,:bio, :firstname,:lastname)
  end
end
