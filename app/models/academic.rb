class Academic < ApplicationRecord
    validates :name, presence: true, uniqueness: { case_sensitive: false }
    validates :image, presence: true
    validates :contact, format: { with: URI.regexp }
    validates :contact, presence: true


    mount_uploader :image, AcademicImageUploader

    has_many :discipline_monitors, dependent: :destroy

end
