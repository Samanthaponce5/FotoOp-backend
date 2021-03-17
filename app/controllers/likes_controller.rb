class LikesController < ApplicationController
    skip_before_action :require_login
    before_action :find_post
    before_action :find_like, only: [:destroy]


   def create
        if already_liked?
          # flash[:notice] = "You can't like more than once"
        else
          @post.likes.create(user_id: current_user.id)
        end
      
      end

      def find_like
        @like = @post.likes.find(params[:id])
     end

      def destroy
        
          @like.destroy
    
        
      end
    private
    def find_post
      @post = Picture.find(params[:picture_id])
    end

    def already_liked?
        Like.where(user_id: current_user.id, picture_id:
        params[:picture_id]).exists?
      end



end
