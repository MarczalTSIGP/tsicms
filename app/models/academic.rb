class Academic < ApplicationRecord
    validates :name, presence: true, uniqueness: { case_sensitive: false }
    validates :contact, presence: true
    validates :image, presence: true
    validates :contact, format: { with: URI.regexp }

    mount_uploader :image, AcademicImageUploader
end
