class PicturesController < ApplicationController
      skip_before_action :require_login

  def index
    if current_user
      user = User.find(current_user.id).followees
      posts = []
      comments = []
      likes=[]
      user.each do |user|
          user.pictures.each do |post|
              posts << post
              comments << post.comments
              likes << post.likes
          end
      end
    
    render json:{ posts:posts,comments:comments,likes:likes}
    end
    
  end
  
  def new
    @picture = Picture.new
end

  def create
    picture = Picture.new(picture_params)
    picture.user_id = current_user.id
    
    # byebug
    if picture.save 
      render json: picture, status: :created
      
    else
      render json: picture.errors, status: :unprocessable_entity
   
    end
  end

  def show
    
    picture = Picture.find(params[:id]) 
    comments = picture.comments
    likes = picture.likes
    # @comment = Comment.new
    render json: {picture:picture, comments:comments, likes:likes}
end

def destroy
  picture = Picture.find(params[:id])
  picture.destroy
end

  private

  def picture_params
    params.require(:picture).permit(:attachment)
  end
end
