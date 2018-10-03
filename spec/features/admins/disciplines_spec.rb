require 'rails_helper'

RSpec.feature 'Discipline', type: :feature do

  let(:admin) { create(:admin) }
  let!(:period) { create_list(:period, 3).sample }
  let(:resource_name) { Discipline.model_name.human }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  describe '#create' do

    before(:each) do
      visit new_admins_discipline_path
    end

    context 'with valid fields' do
      it 'create discipline' do
        attributes = attributes_for(:discipline)

        fill_in 'discipline_name', with: attributes[:name]
        fill_in 'discipline_code', with: attributes[:code]
        fill_in 'discipline_hours', with: attributes[:hours]
        select period.name, from: 'discipline_period_id'
        submit_form

        expect(page.current_path).to eq admins_disciplines_path

        
        within('table tbody') do
          expect(page).to have_content(attributes[:name])
        end
      end
    end

    context 'when invalid fields' do
      it 'show errors' do
        submit_form

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))

        within('div.discipline_name') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
      end
    end

    context 'when has same name'  do
      let(:discipline) { create(:discipline) }

      it 'show errors' do
        fill_in 'discipline_name', with: discipline.name
        submit_form

        within('div.discipline_name') do
          expect(page).to have_content(I18n.t('errors.messages.taken'))
        end
      end

      it 'show errors considering insensitive case' do
        fill_in 'discipline_name', with: discipline.name.downcase
        submit_form

        within('div.discipline_name') do
          expect(page).to have_content(I18n.t('errors.messages.taken'))
        end
      end
    end
  end

  describe '#update' do
    let(:discipline) { create(:discipline) }

    before(:each) do
      visit edit_admins_discipline_path(discipline)
    end

    context 'fill fields' do
      it 'with correct values' do
        expect(page).to have_field 'discipline_name', with: discipline.name
      end
    end

    context 'with valid fields' do
      it 'update discipline' do
        new_name = 'DWW5'
        fill_in 'discipline_name', with: new_name

        submit_form

        expect(page.current_path).to eq admins_disciplines_path

        expect(page).to have_selector('div.alert.alert-success',
                                     text: I18n.t('flash.actions.update.f',
                                                resource_name: resource_name))

        within('table tbody') do
          expect(page).to have_content(new_name)
        end
      end
    end

    context 'when invalid fields' do
      it 'show errors' do
        fill_in 'discipline_name', with: ''
        submit_form

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))

        within('div.discipline_name') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
      end
    end

    context 'when has same name'  do
      let(:other_discipline) { create(:discipline) }

      it 'show errors' do
        fill_in 'discipline_name', with: other_discipline.name
        submit_form

        within('div.discipline_name') do
          expect(page).to have_content(I18n.t('errors.messages.taken'))
        end
      end

      it 'show errors cosidering insensitive case' do
        fill_in 'discipline_name', with: other_discipline.name.downcase
        submit_form

        within('div.discipline_name') do
          expect(page).to have_content(I18n.t('errors.messages.taken'))
        end
      end
    end
  end

  describe '#destroy' do
    it 'discipline' do
      discipline = create(:discipline)
      visit admins_disciplines_path

      destroy_link = "a[href='#{admins_discipline_path(discipline)}'][data-method='delete']"
      find(destroy_link).click

      expect(page).to have_selector('div.alert.alert-success',
                                    text: I18n.t('flash.actions.destroy.f',
                                                resource_name: resource_name))

      within('table tbody') do
        expect(page).not_to have_content(discipline.name)
      end
    end
  end

  describe '#index' do
    let!(:disciplines) { create_list(:discipline, 3) }

    it 'show all discipline with options' do
      visit admins_disciplines_path

      disciplines.each do |discipline|
        expect(page).to have_content(discipline.name)
        expect(page).to have_content(discipline.code)
        

        expect(page).to have_link(href: edit_admins_discipline_path(discipline))
        destroy_link = "a[href='#{admins_discipline_path(discipline)}'][data-method='delete']"
        expect(page).to have_css(destroy_link)
      end
    end 
  end

end
