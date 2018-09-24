class Academic < ApplicationRecord
    validates :name, presence: true, uniqueness: { case_sensitive: false }
    validates :contact, presence: true
    validates :image, presence: true
    validates_format_of :contact, with: URI.regexp
    mount_uploader :image, AcademicImageUploader

end
