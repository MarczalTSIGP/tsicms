require 'rails_helper'

RSpec.feature "Admins", type: :feature do

  describe "#edit" do
    context 'with valid fields' do

      it "update admins' name" do
        admin = create(:admin)
        login_as(admin, scope: :admin)
        new_name = 'Diego Marczal'

        visit edit_admin_registration_path
        fill_in 'admin_name', with: new_name
          fill_in 'admin_current_password', with: 'password'

          find('input[name="commit"]').click

        expect(page.current_path).to eq edit_admin_registration_path
        expect(page).to have_selector('div.alert.alert-info',
                                      text: I18n.t('devise.registrations.updated'))

        within('a.nav-link') do
          expect(page).to have_content(new_name)
        end
      end

    end

    context 'when invalid fields' do

      it "update admins' name" do
        admin = create(:admin)
        login_as(admin, scope: :admin)

        visit edit_admin_registration_path
        fill_in 'admin_name', with: ''
        fill_in 'admin_current_password', with: 'password'

        find('input[name="commit"]').click

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('simple_form.error_notification.default_message'))

        within('div.admin_name') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
      end

    end
  end
end
