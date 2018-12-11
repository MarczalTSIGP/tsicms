require 'rails_helper'

RSpec.describe 'Discipline', type: :feature do
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
        fill_in 'discipline_initials', with: attributes[:initials]
        fill_in 'discipline_theoretical_classes', with: attributes[:theoretical_classes]
        fill_in 'discipline_practical_classes', with: attributes[:practical_classes]
        fill_in 'discipline_distance_classes', with: attributes[:distance_classes]
        fill_in 'discipline_menu', with: attributes[:menu]
        select "#{period.matrix.name} - #{period.name}", from: 'discipline_period_id'

        submit_form

        expect(page).to have_current_path(admins_disciplines_path)

        within('table tbody') do
          expect(page).to have_content(attributes[:name])
          expect(page).to have_content(attributes[:initials])
          expect(page).to have_content(attributes[:code])
          expect(page).to have_content(attributes[:theoretical_classes])
          expect(page).to have_content(attributes[:practical_classes])
          expect(page).to have_content(attributes[:distance_classes])
          expect(page).to have_content(period.name)
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
        within('div.discipline_initials') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
        within('div.discipline_code') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
        within('div.discipline_practical_classes') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
          expect(page).to have_content(I18n.t('errors.messages.not_a_number'))
        end
        within('div.discipline_period') do
          expect(page).to have_content(I18n.t('errors.messages.required'))
        end
      end
    end
  end

  describe '#update' do
    let(:discipline) { create(:discipline) }

    before(:each) do
      visit edit_admins_discipline_path(discipline)
    end

    context 'with fields filled' do
      it 'with correct values' do
        expect(page).to have_field 'discipline_name', with: discipline.name
        expect(page).to have_field 'discipline_practical_classes',
                                   with: discipline.practical_classes
        expect(page).to have_field 'discipline_distance_classes',
                                   with: discipline.distance_classes
        expect(page).to have_field 'discipline_theoretical_classes',
                                   with: discipline.theoretical_classes
        expect(page).to have_field 'discipline_initials',
                                   with: discipline.initials
        expect(page).to have_field 'discipline_code',
                                   with: discipline.code

        selected = "#{discipline.period.matrix.name} - #{discipline.period.name}"
        expect(page).to have_select 'discipline_period_id',
                                    selected: selected
      end
    end

    context 'with valid fields' do
      it 'discipline' do
        new_name = 'new name'
        new_code = 'new code'
        new_practical_classes = 30
        new_distance_classes = 70
        new_theoretical_classes = 20
        new_initials = 'INS80II'

        fill_in 'discipline_name', with: new_name
        fill_in 'discipline_initials', with: new_initials
        fill_in 'discipline_code', with: new_code
        fill_in 'discipline_practical_classes', with: new_practical_classes
        fill_in 'discipline_theoretical_classes', with: new_theoretical_classes
        fill_in 'discipline_distance_classes', with: new_distance_classes
        submit_form

        expect(page).to have_current_path(admins_disciplines_path)
        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.update.f',
                                                   resource_name: resource_name))

        within('table tbody') do
          expect(page).to have_content(new_name)
          expect(page).to have_content(new_code)
          expect(page).to have_content(new_initials)
          expect(page).to have_content(new_practical_classes)
          expect(page).to have_content(new_distance_classes)
          expect(page).to have_content(new_theoretical_classes)
        end
      end
    end

    context 'when invalid fields' do
      it 'show errors' do
        fill_in 'discipline_name', with: ''
        fill_in 'discipline_code', with: ''
        fill_in 'discipline_initials', with: ''
        fill_in 'discipline_hours', with: ''
        fill_in 'discipline_menu', with: ''
        fill_in 'discipline_practical_classes', with: ''
        fill_in 'discipline_theoretical_classes', with: ''
        fill_in 'discipline_distance_classes', with: ''

        submit_form

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))

        within('div.discipline_name') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
        within('div.discipline_code') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
        within('div.discipline_initials') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
        within('div.discipline_treoretical_classes') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
          expect(page).to have_content(I18n.t('errors.messages.not_a_number'))
        end
        within('div.discipline_distance_classes') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
          expect(page).to have_content(I18n.t('errors.messages.not_a_number'))
        end
        within('div.discipline_practical_classes') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
          expect(page).to have_content(I18n.t('errors.messages.not_a_number'))
        end
      end
    end
  end

  describe '#show' do
    let(:discipline) { create(:discipline) }

    it 'show all discipline with options' do
      visit admins_discipline_path(discipline)
      expect(page).to have_content(discipline.name)
      expect(page).to have_content(discipline.code)
      expect(page).to have_content(discipline.initials)
      expect(page).to have_content(discipline.hours)
      expect(page).to have_content(discipline.period.name)
      expect(page).to have_content(discipline.period.matrix.name)
      expect(page).to have_link(href: admins_disciplines_path)
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

      expect(page).to have_link(href: new_admins_discipline_path)

      disciplines.each do |discipline|
        expect(page).to have_content(discipline.name)
        expect(page).to have_content(discipline.initials)
        expect(page).to have_content(discipline.period.name)
        expect(page).to have_content(discipline.period.matrix.name)

        expect(page).to have_link(href: edit_admins_discipline_path(discipline))
        expect(page).to have_link(href: admins_discipline_path(discipline))
        destroy_link = "a[href='#{admins_discipline_path(discipline)}'][data-method='delete']"
        expect(page).to have_css(destroy_link)
      end
    end
  end
end
