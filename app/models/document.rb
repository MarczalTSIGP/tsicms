class Document < ApplicationRecord
  validates :file, presence: true
  belongs_to :gallery

  mount_uploader :file, DocumentFileUploader
end
