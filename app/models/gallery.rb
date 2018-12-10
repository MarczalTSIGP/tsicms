class Gallery < ApplicationRecord
  enum context: { course: 'course', static_page: 'static_page', document: 'document' }
  validates :context, presence: true, uniqueness: { case_sensitive: true }
  has_many :pictures, dependent: :destroy
  has_many :documents, dependent: :destroy
  accepts_nested_attributes_for :pictures
  accepts_nested_attributes_for :documents

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

  def upload_documents(documents)
    if documents.empty?
      errors[:documents] << I18n.t('errors.messages.blank')
      return false
    end

    documents.map! { |document| { file: document } }

    return true if update(documents_attributes: documents)

    errors.add(:documents, errors['documents.file'].join('. '))
    false
  end

  def contains_pictures
    course? || static_page?
  end
end
