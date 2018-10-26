class Academic < ApplicationRecord
    validates :name, presence: true
    validates :contact, presence: true
    validates :image, presence: true
    validates :contact, presence: true, format: { with: URI.regexp }

    mount_uploader :image, AcademicImageUploader

    has_many :discipline_monitors, dependent: :destroy
end
