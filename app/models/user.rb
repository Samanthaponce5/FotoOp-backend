class User < ApplicationRecord
    include Rails.application.routes.url_helpers

    has_secure_password
    
    has_many :pictures
    has_many :comments
    has_many :likes, dependent: :destroy

     # this allows an account to see who is following them
     has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
     has_many :followees, through: :followed_users
     # this allows an account to see who they are following
     has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
     has_many :followers, through: :following_users

    has_one_attached :avatar
end
