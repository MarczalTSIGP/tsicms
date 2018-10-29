class Gallery < ApplicationRecord
  validates :context, presence: true, uniqueness: { case_sensitive: false }
  enum context: { course: 'course', static_page: 'static_page' }
  has_many :pictures, dependent: :destroy
end
