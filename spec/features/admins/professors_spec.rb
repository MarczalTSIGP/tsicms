require 'rails_helper'

RSpec.feature 'Admin Professors', type: :feature do

  let(:admin) {create :admin}
  let(:resource_name) { Professor.model_name.human }

  before(:each) do
    login_as admin, scope: :admin
  end

  describe '#create' do

    before(:each) do
      @category = create_list(:professor_category, 2).sample
      @title = create_list(:professor_title, 3).sample
      visit new_admins_professor_path
    end

    context 'with valid fields' do
      it 'create professor' do
        attributes = attributes_for(:professor)

        fill_in 'professor_name', with: attributes[:name]
        fill_in 'professor_lattes', with: attributes[:lattes]
        fill_in 'professor_occupation_area', with: attributes[:occupation_area]
        fill_in 'professor_email', with: attributes[:email]
        select @category.name, from: 'professor[professor_category_id]'
        select @title.name, from: 'professor[professor_title_id]'
        submit_form

        expect(page.current_path).to eq admins_professors_path

        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.create.m',
                                                   resource_name: resource_name))

        within('table tbody') do
          expect(page).to have_content(attributes[:name])
        end
      end
    end
    context 'when invalid fields' do
      it 'cannot create professor' do
        submit_form
        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))
        within('div.professor_name') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
        within('div.professor_occupation_area') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
        within('div.professor_email') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
        within('div.professor_professor_category') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
        within('div.professor_professor_title') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
      end
    end
  end

  describe '#update' do
    before(:each) do
      @professor = create :professor
      visit edit_admins_professor_path(@professor)
    end
    context 'with valid fields' do
      it "update professor's fields" do
        new_name = 'Lucas Sartori'
        fill_in 'professor_name', with: new_name
        submit_form

        expect(page.current_path).to eq admins_professor_path(@professor)
        expect(page).to have_content("#{new_name}")
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

      destroy_link = "a[href='#{admins_professor_path(professor)}'][data-method='delete']"
      find(destroy_link).click

      expect(page).to have_selector('div.alert.alert-success',
                                    text: I18n.t('flash.actions.destroy.m',
                                                 resource_name: resource_name))

      within('table tbody') do
        expect(page).not_to have_content(professor.name)
      end
    end

  end

  describe '#index' do
    let!(:professors) {create_list(:professor, 2)}

    it 'show all professors' do
      visit admins_professors_path

      professors.each do |professor|
        expect(page).to have_content(professor.name)
        expect(page).to have_content(I18n.l(professor.created_at, format: :long))

        expect(page).to have_link(href: edit_admins_professor_path(professor))
        destroy_link = "a[href='#{admins_professor_path(professor)}'][data-method='delete']"
        expect(page).to have_css(destroy_link)
      end
    end
  end

  describe '#show' do
    context 'show professors' do
      it 'show professor page' do
        professor = create(:professor)
        visit admins_professor_path(professor)

        expect(page).to have_content(professor.name)
        expect(page).to have_content(professor.email)
        expect(page).to have_content(professor.lattes)
        expect(page).to have_content(professor.occupation_area)
        expect(page).to have_content(professor.professor_category.name)
        expect(page).to have_content(professor.professor_title.name)
      end
    end
  end
end
