class Gallery < ApplicationRecord
  enum context: { course: 'course', static_page: 'static_page' }
  validates :context, presence: true, uniqueness: { case_sensitive: true }
  has_many :pictures, dependent: :destroy
end
