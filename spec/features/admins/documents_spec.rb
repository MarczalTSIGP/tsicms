require 'rails_helper'

RSpec.describe 'Documents', type: :feature do
  let(:admin) { create(:admin) }
  let(:gallery) { create(:gallery, :context_document) }
  let(:resource_name) { Document.model_name.human }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  describe '#create' do
    before(:each) do
      visit new_admins_document_path(gallery.context)
    end

    context 'with valid fields' do
      it 'upload document' do
        document_total = gallery.documents.count

        documents = [FileSpecHelper.pdf.path, FileSpecHelper.pdf.path, FileSpecHelper.pdf.path]
        attach_file 'gallery_documents', documents
        submit_form

        expect(page).to have_current_path(admins_galleries_path(gallery.context))

        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.create.f',
                                                   resource_name: resource_name))

        expect(gallery.documents.count).to be == document_total + documents.count
      end
    end

    context 'with invalid fields' do
      it 'show errors' do
        image_path = FileSpecHelper.image.path
        attach_file 'gallery_documents', image_path
        submit_form

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))

        within('div.gallery_documents') do
          expect(page).to have_content(I18n.t('errors.messages.extension_whitelist_error',
                                              extension: "\"#{File.extname(image_path).delete('.')}\"",
                                              allowed_types: 'pdf, doc, docx, xls, xlsx, ppt, pptx, csv, odt, odp, ods'))
        end
      end
    end
  end

  describe '#destroy' do
    it 'gallery document' do
      visit admins_galleries_path(gallery.context)

      document = gallery.documents.first

      click_on_destroy_link(admins_document_path(gallery.context, document))

      expect_alert_success(resource_name, 'flash.actions.destroy.f')

      within("#gallery-#{gallery.context}") do
        expect(page).not_to have_css("img[src*='#{document.file.url}']")
      end
    end
  end
end
