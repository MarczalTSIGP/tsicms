class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  #mount_uploader :image, AdminsImageUploader
  has_one_attached :image

  before_create :default_image

  protected
  def default_image
    image_path = Rails.root.join('app', 'assets', 'images', 'default-avatar.png')
    self.image.attach(io: File.open(image_path),
                      filename: 'default-avatar.png', content_type: 'image/png')
  end
end
