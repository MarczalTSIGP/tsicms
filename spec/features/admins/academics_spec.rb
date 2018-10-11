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

        expect(page.current_path).to eq admins_academics_path

        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.create.m',
                                                  resource_name: resource_name))

        within('table tbody') do
          expect(page).to have_content(attributes[:name])

        end
      end
    end

    context 'with invalid fields' do
      it 'show errors' do
        attach_file 'academic_image', FileSpecHelper.pdf.path
        submit_form

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))

        within('div.academic_name') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
        within('div.academic_contact') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
        expect(page).to have_unchecked_field('academic_graduated')
        within('div.academic_image') do
          expect(page).to have_content(I18n.t('errors.messages.extension_whitelist_error',
                                              extension: '"pdf"',
                                              allowed_types: 'jpg, jpeg, gif, png'))
        end
      end
    end
  end
  describe '#update' do
    let(:academic) { create(:academic) }

    before(:each) do
      visit edit_admins_academic_path(academic)
    end

    context 'fill fields' do
      it 'with correct values' do
        expect(page).to have_field 'academic_name',
          with: academic.name
        expect(page).to have_field 'academic_contact',
          with: academic.contact
        expect(page).to have_unchecked_field('academic_graduated')
        expect(page).to have_css("img[src*='#{academic.image}']")
      end
    end

    context 'with valid fields' do
      it 'update academic' do
        attributes = attributes_for(:academic)

        new_name = 'Pedro'
        fill_in 'academic_name', with: new_name
        fill_in 'academic_contact', with: attributes[:contact]
        attach_file 'academic_image', FileSpecHelper.image.path
        check('academic_graduated')
        submit_form

        expect(page.current_path).to eq admins_academics_path

        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.update.m',
                                                   resource_name: resource_name))

        within('table tbody') do
          expect(page).to have_content(new_name)

        end
      end
    end

    context 'with invalid fields' do
      it 'show errors' do
        fill_in 'academic_name', with: ''
        fill_in 'academic_contact', with: ''
        check('academic_graduated')
        attach_file 'academic_image', FileSpecHelper.pdf.path
        submit_form

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))

        within('div.academic_name') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
        within('div.academic_contact') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
        expect(page).to have_checked_field('academic_graduated')

        within('div.academic_image') do
          expect(page).to have_content(I18n.t('errors.messages.extension_whitelist_error',
                                              extension: '"pdf"',
                                              allowed_types: 'jpg, jpeg, gif, png'))
        end
      end
    end
  end

  describe '#destroy' do
    it 'academic' do
      academic = create(:academic)
      visit admins_academics_path

      destroy_path = "/admins/academics/#{academic.id}"
      click_link href: destroy_path

      expect(page).to have_selector('div.alert.alert-success',
                                    text: I18n.t('flash.actions.destroy.m',
                                                 resource_name: resource_name))

      within('table tbody') do
        expect(page).not_to have_content(academic.name)
      end
    end
  end

  describe  '#index' do
    let!(:academics) { create_list(:academic, 3) }

    it 'show all academics with options' do
      visit admins_academics_path

      academics.each do |a|
        expect(page).to have_content(a.name)
        expect(page).to have_content(I18n.t("helpers.boolean.#{a.graduated}"))
        expect(page).to have_content(I18n.l(a.created_at, format: :long))

        expect(page).to have_link(href: edit_admins_academic_path(a))
        destroy_link = "a[href='#{admins_academic_path(a)}'][data-method='delete']"
        expect(page).to have_css(destroy_link)
      end
    end
  end
end
