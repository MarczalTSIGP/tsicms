require 'rails_helper'

RSpec.feature 'Discipline Monitors', type: :feature do
  let(:admin) {create :admin}
  let(:resource_name) { DisciplineMonitor.model_name.human }

  let!(:academic) {
    create_list(:academic, 2).sample
  }
  let!(:monitor_type) {
    create_list(:monitor_type, 2).sample
  }
  let!(:professor) {
    create_list(:professor, 2).sample
  }
  let!(:discipline) {
    create_list(:discipline, 2).sample
  }

  before(:each) do
    login_as admin, scope: :admin
  end

  describe '#create' do

    before(:each) do
      visit new_admins_discipline_monitor_path
    end

    context 'with valid fields' do
      it 'create discipline monitor' do
        attributes = attributes_for(:discipline_monitor)

        fill_in 'discipline_monitor_description', with: attributes[:description]
        select '2018', from: 'discipline_monitor_year'
        select '1º', from: 'discipline_monitor_semester'
        select monitor_type.name, from: 'discipline_monitor_monitor_type_id'
        select academic.name, from: 'discipline_monitor_academic_id'
        select professor.name, from: 'discipline_monitor_professor_ids'
        select discipline.name, from: 'discipline_monitor_discipline_ids'

        submit_form

        expect(page.current_path).to eq admins_discipline_monitors_path

        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.create.f',
                                                    resource_name: resource_name))

        within('table tbody') do
          expect(page).to have_content(attributes[:academic])
        end
      end
    end

    context 'with invalid fields' do
      it 'show errors' do
        submit_form

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))
        within('div.discipline_monitor_semester') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
        within('div.discipline_monitor_description') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
        within('div.discipline_monitor_academic') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
        within('div.discipline_monitor_monitor_type') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
        within('div.discipline_monitor_discipline_ids') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
        within('div.discipline_monitor_professor_ids') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
      end
    end
  end

  describe '#Update' do

    let!(:discipline_monitor) { create(:discipline_monitor) }

    before(:each) do
      visit edit_admins_discipline_monitor_path(discipline_monitor)
    end

    context 'fill fields' do
      it 'with correct values' do
        expect(page).to have_field 'discipline_monitor_year',
          with: discipline_monitor.year
        expect(page).to have_field 'discipline_monitor_description',
          with: discipline_monitor.description
        expect(page).to have_select 'discipline_monitor_academic_id',
          selected: discipline_monitor.academic.name
        expect(page).to have_select 'discipline_monitor_monitor_type_id',
          selected: discipline_monitor.monitor_type.name

        expect(page).to have_select 'discipline_monitor_discipline_ids',
          selected: discipline_monitor.disciplines.map(&:name)
        expect(page).to have_select 'discipline_monitor_professor_ids',
          selected: discipline_monitor.professors.map(&:name)
      end
    end

    context 'with valid fields' do
      it 'update discipline monitor' do
        attributes = attributes_for(:discipline_monitor)

        new_year = 2018
        new_semester = '2º'

        fill_in 'discipline_monitor_description', with: attributes[:description]
        select new_year, from: 'discipline_monitor_year'
        select new_semester, from: 'discipline_monitor_semester'
        select monitor_type.name, from: 'discipline_monitor_monitor_type_id'
        select academic.name, from: 'discipline_monitor_academic_id'

        select professor.name, from: 'discipline_monitor_professor_ids'
        select discipline.name, from: 'discipline_monitor_discipline_ids'
        submit_form

        expect(page.current_path).to eq admins_discipline_monitors_path

        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.update.f',
                                                    resource_name: resource_name))

        within('table tbody') do
          expect(page).to have_content(academic.name)
        end
      end
    end

    context 'with invalid fields' do
      it 'show errors' do

        fill_in 'discipline_monitor_description', with: ''
        submit_form

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))

        within('div.discipline_monitor_description') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
      end
    end
  end

  describe '#destroy' do
    it 'discipline_monitor' do
      discipline_monitor = create(:discipline_monitor)

      visit admins_discipline_monitors_path

      destroy_link = "a[href='#{admins_discipline_monitor_path(discipline_monitor)}'][data-method='delete']"
      find(destroy_link).click

      expect(page).to have_selector('div.alert.alert-success',
                                    text: I18n.t('flash.actions.destroy.f',
                                                resource_name: resource_name))

      within('table tbody') do
        expect(page).not_to have_content(discipline_monitor.academic.name)
      end
    end
  end

  describe  '#index' do
    let!(:discipline_monitors) { create_list(:discipline_monitor, 3) }

    it 'show all discipline monitors' do
      visit admins_discipline_monitors_path

      discipline_monitors.each do |m|
        expect(page).to have_content(m.year)
        expect(page).to have_content(I18n.t("enums.semesters.#{m.semester}"))
        expect(page).to have_content(m.academic.name)
        expect(page).to have_content(m.monitor_type.name)
        expect(page).to have_content(m.disciplines.first.code)

        expect(page).to have_link(href: edit_admins_discipline_monitor_path(m))
        destroy_link = "a[href='#{admins_discipline_monitor_path(m)}'][data-method='delete']"
        expect(page).to have_css(destroy_link)
      end
    end
  end
end
