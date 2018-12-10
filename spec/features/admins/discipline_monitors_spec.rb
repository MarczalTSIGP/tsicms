require 'rails_helper'

RSpec.describe 'Discipline Monitors', type: :feature do
  let(:admin) { create :admin }
  let(:resource_name) { DisciplineMonitor.model_name.human }
  let!(:academic) { create_list(:academic, 2).sample }
  let!(:monitor_type) { create_list(:monitor_type, 2).sample }
  let!(:professor) { create_list(:professor, 2).sample }
  let!(:discipline) { create_list(:discipline, 2).sample }
  let!(:discipline_monitor) { create(:discipline_monitor) }

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

        expect(page).to have_current_path(admins_discipline_monitors_path)
        text = I18n.t('flash.actions.create.f', resource_name: resource_name)
        expect(page).to have_flash(:success, text: text)
        expect_page_have_in('table tbody', attributes[:academic])
      end
    end

    context 'with invalid fields' do
      it 'show errors' do
        submit_form

        expect(page).to have_flash(:danger, text: I18n.t('flash.actions.errors'))
        fields = %w[div.discipline_monitor_semester]
        fields.push 'div.discipline_monitor_description'
        fields.push 'div.discipline_monitor_academic'
        fields.push 'div.discipline_monitor_monitor_type'
        fields.push 'div.discipline_monitor_discipline_ids'
        fields.push ' div.discipline_monitor_professor_ids'
        expect_page_blank_messages(fields)
      end
    end
  end

  describe '#update' do
    before(:each) do
      visit edit_admins_discipline_monitor_path(discipline_monitor)
    end

    context 'with fields filled' do
      it 'with correct values' do
        fields = [
          { id: 'discipline_monitor_academic_id', value: discipline_monitor.academic.name },
          { id: 'discipline_monitor_monitor_type_id', value: discipline_monitor.monitor_type.name },
          { id: 'discipline_monitor_discipline_ids', value: discipline_monitor.disciplines.map(&:name) },
          { id: 'discipline_monitor_professor_ids', value: discipline_monitor.professors.map(&:name) }
        ]
        expect_page_have_value('discipline_monitor_year', discipline_monitor.year)
        expect_page_have_value('discipline_monitor_description', discipline_monitor.description)
        fields.each do |f|
          expect_page_have_selected(f.id, f.value)
        end
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

        expect(page).to have_current_path(admins_discipline_monitors_path)
        text = I18n.t('flash.actions.update.f', resource_name: resource_name)
        expect(page).to have_flash(:success, text: text)
        expect_page_have_in('table tbody', academic.name)
      end
    end

    context 'with invalid fields' do
      it 'show errors' do
        fill_in 'discipline_monitor_description', with: ''
        submit_form
        expect(page).to have_flash(:danger, text: I18n.t('flash.actions.errors'))
        expect_page_blank_message('div.discipline_monitor_description')
      end
    end
  end

  describe '#destroy' do
    it 'discipline_monitor' do
      visit admins_discipline_monitors_path

      click_on_destroy_link(admins_discipline_monitor_path(discipline_monitor))
      text = I18n.t('flash.actions.destroy.f', resource_name: resource_name)
      expect(page).to have_flash(:success, text: text)
      expect_page_not_have_in('table tbody', discipline_monitor.academic.name)
    end
  end

  describe '#index' do
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
        expect_page_have_destroy_link(admins_discipline_monitor_path(m))
      end
    end
  end
end
