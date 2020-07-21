class CommentsController < ApplicationController
    skip_before_action :require_login

    def new
        @comment = Comment.new
    end

    def create
       
        comment = Comment.new(comments_params)
        comment.user_id = current_user.id
       if comment.save
        render json: comment
       else
        render json: {errors: "Comment error"}

       end
       
    end

    def destroy
        comment = Comment.find(picture_id: params[:picture_id])
        comment.destroy
       redirect_to(comment.picture)

        # @post = Post.find(params[:post_id])
        # @comment = @post.comments.find(params[:id])
        # @comment.destroy
        # redirect_to post_path(@post)
    end

    # def edit
    #     @comment = Comment.find(params[:id])
    # end

    # def update
    #     Comment.find(params[:id]).update(params[:content])
    # end

    # def delete
    #     Comment.find(params[:id]).delete
    # end
    private
    def comments_params
    params.permit(:comment,:user_id,:picture_id)
    end

end
