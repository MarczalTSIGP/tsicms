require 'rails_helper'

RSpec.feature "Admins", type: :feature do

  describe "#edit" do
    let(:admin) { create(:admin) }

    before(:each) do
      login_as(admin, scope: :admin)
      visit edit_admin_registration_path
    end

    context 'with valid fields' do

      it "update admins' name and image" do
        new_name = 'Diego Marczal'

        fill_in 'admin_name', with: new_name
        fill_in 'admin_current_password', with: 'password'
        attach_file 'admin_image', FileSpecHelper.image.path
        submit_form

        expect(page.current_path).to eq edit_admin_registration_path
        expect(page).to have_selector('div.alert.alert-info',
                                      text: I18n.t('devise.registrations.updated'))

        within('a.nav-link') do
          expect(page).to have_content(new_name)
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

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('simple_form.error_notification.default_message'))

        within('div.admin_name') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
        within('div.admin_image') do
          expect(page).to have_content(I18n.t('errors.messages.extension_whitelist_error',
                                              extension: '"pdf"',
                                              allowed_types: 'jpg, jpeg, gif, png'))
        end
      end

    end
  end
end
