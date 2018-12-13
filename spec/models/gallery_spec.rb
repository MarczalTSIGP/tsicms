require 'rails_helper'

RSpec.describe Gallery, type: :model do
  describe 'validates' do
    subject { create(:gallery) }

    it { is_expected.to validate_presence_of(:context) }
    it { is_expected.to validate_uniqueness_of(:context).ignoring_case_sensitivity }
  end

  describe 'associations' do
    it { is_expected.to have_many(:pictures).dependent(:destroy) }
  end

  describe 'galleries types' do
    it 'return images from course gallery' do
      course_gallery = create(:gallery, :context_course)

      gallery = Gallery.find_by!(context: Gallery.contexts[:course])

      expect(gallery).to eq(course_gallery)
    end

    it 'return images from static page gallery' do
      static_page_gallery = create(:gallery, :context_static_page)

      gallery = Gallery.find_by!(context: Gallery.contexts[:static_page])

      expect(gallery).to eq(static_page_gallery)
    end

    it 'return files from document gallery' do
      document_gallery = create(:gallery, :context_document)

      gallery = Gallery.find_by!(context: Gallery.contexts[:document])

      expect(gallery).to eq(document_gallery)
    end
  end
end
