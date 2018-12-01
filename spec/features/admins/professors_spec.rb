require 'rails_helper'

RSpec.describe 'Admin Professors', type: :feature do
  let(:admin) { create :admin }
  let(:resource_name) { Professor.model_name.human }

  before(:each) do
    login_as admin, scope: :admin
  end

  describe '#create' do
    let!(:category) { create_list(:professor_category, 2).sample }
    let!(:title) { create_list(:professor_title, 3).sample }

    before(:each) do
      visit new_admins_professor_path
    end

    context 'with valid fields' do
      it 'create professor' do
        attributes = attributes_for(:professor)
        fill_in 'professor_name', with: attributes[:name]
        fill_in 'professor_email', with: attributes[:email]
        choose 'professor_gender_male'
        fill_in 'professor_lattes', with: attributes[:lattes]
        select category.name, from: 'professor[professor_category_id]'
        select title.name, from: 'professor[professor_title_id]'
        fill_in 'professor_occupation_area', with: attributes[:occupation_area]

        attach_file 'professor_image', FileSpecHelper.image.path
        submit_form

        expect(page).to have_current_path(admins_professors_path)

        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.create.m',
                                                   resource_name: resource_name))

        expect_page_have_in('table tbody', attributes[:name])
      end
    end

    context 'when invalid fields' do
      it 'cannot create professor' do
        submit_form
        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))
        have_contains('div.professor_name', I18n.t('errors.messages.blank'))
        have_contains('div.professor_occupation_area', I18n.t('errors.messages.blank'))
        have_contains('div.professor_email', I18n.t('errors.messages.blank'))
        have_contains('div.professor_professor_category', I18n.t('errors.messages.blank'))
        have_contains('div.professor_professor_title', I18n.t('errors.messages.blank'))
      end
    end
  end

  describe '#update' do
    let(:professor) { create :professor }

    before(:each) do
      visit edit_admins_professor_path(professor)
    end

    context 'with valid fields' do
      it "update professor's fields" do
        new_name = 'Lucas Sartori'
        fill_in 'professor_name', with: new_name
        submit_form

        expect(page).to have_current_path(admins_professor_path(professor))
        expect(page).to have_content(new_name.to_s)
      end
    end

    context 'when invalid fields' do
      it 'cannot update professor' do
        fill_in 'professor_name', with: ''
        submit_form
        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))
      end
    end
  end

  describe '#destroy' do
    it 'professor' do
      professor = create(:professor)
      visit admins_professors_path

      click_on_destroy_link(admins_professor_path(professor))
      expect_alert_success(resource_name, 'flash.actions.destroy.m')
      expect_page_not_have_in('table tbody', professor.name)
    end

    it 'professor unless has dependet' do
      ap = create(:activity_professor)
      visit admins_professors_path

      click_on_destroy_link(admins_professor_path(ap.professor))
      alert_message = I18n.t('flash.actions.destroy.bond', resource_name: resource_name)
      expect(page).to have_selector('div.alert.alert-warning', text: alert_message)
      expect(page).to have_content('table tbody', ap.professor.name)
    end
  end

  describe '#index' do
    let!(:professors) { create_list(:professor, 2) }

    it 'show all professors' do
      visit admins_professors_path

      professors.each do |professor|
        expect(page).to have_content(professor.name)
        expect(page).to have_content(I18n.l(professor.created_at, format: :long))

        expect(page).to have_link(href: admins_professor_path(professor))
        expect(page).to have_link(href: edit_admins_professor_path(professor))
        destroy_link = "a[href='#{admins_professor_path(professor)}'][data-method='delete']"
        expect(page).to have_css(destroy_link)
      end
    end
  end

  describe '#show' do
    it 'show professor page' do
      professor = create(:professor)
      visit admins_professor_path(professor)

      expect(page).to have_content(professor.name)
      expect(page).to have_content(professor.gender)
      expect(page).to have_content(professor.email)
      expect(page).to have_content(professor.lattes)
      expect(page).to have_content(professor.occupation_area)
      expect(page).to have_content(professor.professor_category.name)
      expect(page).to have_content(professor.professor_title.name)
    end
  end
end
