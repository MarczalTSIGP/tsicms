class Gallery < ApplicationRecord
  enum context: { course: 'course', static_page: 'static_page', document: 'document' }
  validates :context, presence: true, uniqueness: { case_sensitive: true }
  has_many :pictures, dependent: :destroy
  has_many :documents, dependent: :destroy
  accepts_nested_attributes_for :pictures
  accepts_nested_attributes_for :documents

  def upload_images(pictures)
    upload(pictures, 'pictures', 'image')
  end

  def upload_documents(documents)
    upload(documents, 'documents', 'file')
  end

  def contains_pictures
    course? || static_page?
  end

  private

  def upload(files, table, attribute)
    if files.empty?
      errors[table.to_s] << I18n.t('errors.messages.blank')
      return false
    end

    files.map! { |file| { "#{attribute}": file } }

    return true if update("#{table}_attributes": files)

    errors.add(table.to_s, errors["#{table}.#{attribute}"].join('. '))
    false
  end
end
