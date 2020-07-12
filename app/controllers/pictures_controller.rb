class PicturesController < ApplicationController
      skip_before_action :require_login

  def index
    render json: Picture.all.with_attached_attachment.order(id: :desc)
  end
  
  def new
    @post = Post.new
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
    
    @post = Picture.find(params[:id]) 
    # @comment = Comment.new
end
  private

  def picture_params
    params.require(:picture).permit(:attachment)
  end
end
