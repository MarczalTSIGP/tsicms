class Gallery < ApplicationRecord
  enum context: { course: 'course', static_page: 'static_page' }
  validates :context, presence: true, uniqueness: { case_sensitive: true }
  has_many :pictures, dependent: :destroy
  accepts_nested_attributes_for :pictures

  def upload_images(pictures)
    if pictures.empty?
      errors[:pictures] << I18n.t('errors.messages.blank')
      return false
    end

    pictures.map! { |picture| { image: picture } }

    return true if update(pictures_attributes: pictures)

    errors.add(:pictures, errors['pictures.image'].join('. '))
    false
  end
end
