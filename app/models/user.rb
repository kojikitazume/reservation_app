class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_many :reservations, dependent: :destroy
    has_many :rooms, dependent: :destroy
    mount_uploader :avatar, AvatarUploader
    mount_uploader :profile_image, AvatarUploader
  end

