class User < ApplicationRecord
    include Rails.application.routes.url_helpers

    has_secure_password
    
    has_many :pictures
    has_many :comments
    has_many :likes, dependent: :destroy

    has_one_attached :avatar
end
