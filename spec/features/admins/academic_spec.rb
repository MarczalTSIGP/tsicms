require 'rails_helper'

RSpec.feature 'Academics', type: :feature do

  let(:admin) { create(:admin) }
  let(:resource_name) { Academic.model_name.human }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  describe '#create' do

    before(:each) do
      visit new_admins_academic_path
    end

    context 'with valid fields' do
      it 'create academic' do
        attributes = attributes_for(:academic)

        fill_in 'academic_name', with: attributes[:name]
        fill_in 'academic_contact', with: attributes[:contact]
        check('academic_graduated')
        attach_file 'academic_image', FileSpecHelper.image.path
        submit_form

        #p page.body

        expect(page.current_path).to eq admins_academics_path

        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.create.m',
                                                  resource_name: resource_name))

        within('table tbody') do
          expect(page).to have_content(attributes[:name])

        end
      end
    end
  end
end
