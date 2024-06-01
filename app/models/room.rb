class Room < ApplicationRecord
    class Room < ApplicationRecord
        belongs_to :user
        has_many :reservations, dependent: :destroy
        has_one_attached :image
        mount_uploader :image, ImageUploader
        
        validates :name, :description, :price, :address, presence: true
        validates :price, numericality: { greater_than_or_equal_to: 1 }
      end
end
