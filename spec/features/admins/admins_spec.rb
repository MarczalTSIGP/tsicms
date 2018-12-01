require 'rails_helper'

RSpec.describe 'Admins', type: :feature do
  describe '#edit' do
    let(:admin) {create(:admin)}

    before(:each) do
      login_as(admin, scope: :admin)
      visit edit_admin_registration_path
    end

    context 'with valid fields' do
      it "update admins' name and image" do
        new_name = 'Diego Marczal'

        fill_in 'admin_name', with: new_name
        fill_in 'admin_current_password', with: 'password'

        submit_form

        fill_in 'admin_current_password', with: 'password'
        attach_file 'admin_image', FileSpecHelper.image.path
        submit_form

        expect(page).to have_current_path(edit_admin_registration_path)
        expect(page).to have_flash(:info, text: I18n.t('devise.registrations.updated'))
        expect_page_have_in('a.nav-link', new_name)
        within('a.nav-link') do
          admin.reload
          expect(page).to have_css("span[style=\"background-image: url('#{admin.image}')\"]")
        end
      end
    end

    context 'when invalid fields' do
      it "not update admins' name and image" do
        fill_in 'admin_name', with: ''
        fill_in 'admin_current_password', with: 'password'
        attach_file 'admin_image', FileSpecHelper.pdf.path
        submit_form

        expect(page).to have_flash(:danger, text: I18n.t('simple_form.error_notification.default_message'))
        expect_page_have_blank_message('div.admin_name')
        expect_page_not_have_in('div.admin_image', I18n.t('errors.messages.extension_whitelist_error',
                                                          extension: '"pdf"',
                                                          allowed_types: 'jpg, jpeg, gif, png'))
      end
    end
  end
end
