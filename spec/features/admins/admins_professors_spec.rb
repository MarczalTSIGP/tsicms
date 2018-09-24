require 'rails_helper'

RSpec.feature 'Admin Professors', type: :feature do

  let(:admin) {create :admin}

  before(:each) do
    login_as admin, scope: :admin
  end

  describe '#edit' do
    before(:each) do
      @professor = create :professor
      visit edit_admins_professor_path(@professor)
    end
    context 'with valid fields' do
      it "update professor's fields" do
        new_name = 'Lucas Sartori'
        fill_in 'professor_name', with: new_name
        submit_form
        expect(page).to have_content("Detalhes do professor: #{new_name}")
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

  describe '#create' do
    before(:each) do
      @category = create_list(:professor_category, 2).sample
      @title = create_list(:professor_title, 3).sample
      visit new_admins_professor_path
    end
    context 'with valid fields' do
      it 'create professor' do
        new_name = 'Lucas Sartori'
        new_email = 'email@gmail.com'
        fill_in 'professor_name', with: new_name
        fill_in 'professor_lattes', with: new_name
        fill_in 'professor_occupation_area', with: new_name
        fill_in 'professor_email', with: new_email
        select @category.name, from: 'professor[professor_category_id]'
        select @title.description, from: 'professor[professor_title_id]'
        submit_form
      end
    end
    context 'when invalid fields' do
      it 'cannot create professor' do
        submit_form
        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))
      end
    end
  end

  describe '#destroy' do
    context 'must be destroy professor' do
      it 'destroy professor' do
        professor = create :professor
        visit admins_professors_path
        expect {click_link '', href: admins_professor_path(professor)}.to change(Professor, :count).by(0)
      end
    end
  end

  describe '#show' do
    context 'show professors' do
      it 'show all professors' do
        visit admins_professors_path
        expect(page).to have_content('Professores')
      end
      it 'show professor page' do
        professor = create :professor
        visit admins_professor_path(professor)
        expect(page).to have_content(professor.name)
      end
    end
  end
end
