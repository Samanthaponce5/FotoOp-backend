class Picture < ApplicationRecord
    include ActiveModel::Serializers::JSON

    has_one_attached :attachment
    belongs_to :user
  # has_many :likes
  # has_many :comments, dependent: :destroy
 

#   validates :attachment, presence: true



  
    def attributes
      {
        'id' => nil,
        'updated_at' => nil,
        'created_at' => nil,
        'user_id' => nil,
        'description' => nil,
        'attachment_url' => nil
      }
    end
  
    def attachment_url
      Rails.application.routes.url_helpers.rails_representation_url(
        attachment.variant(resize_to_limit: []).processed, only_path: true
      )
    end
end
