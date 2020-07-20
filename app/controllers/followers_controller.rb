class FollowersController < ApplicationController
    skip_before_action :require_login

    def new
        follow = Follow.new
    end

    def create
        follow = Follow.create(followee_id: params[:followee_id], follower_id: current_user.id)

        if follow.valid?
            render json: follow
        else
            render json: {errors: "error"}

        end
    end

    def delete
        Follow.find(params[:id]).delete
    end

end
