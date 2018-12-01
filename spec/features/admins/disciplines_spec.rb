require 'rails_helper'

RSpec.describe 'Discipline', type: :feature do
  let(:admin) {create(:admin)}
  let!(:period) {create_list(:period, 3).sample}
  let(:resource_name) {Discipline.model_name.human}

  before(:each) do
    login_as(admin, scope: :admin)
  end

  describe '#create' do
    before(:each) do
      visit new_admins_discipline_path
    end

    context 'with valid fields' do
      it 'discipline' do
        attributes = attributes_for(:discipline)

        fill_in 'discipline_name', with: attributes[:name]
        fill_in 'discipline_code', with: attributes[:code]
        fill_in 'discipline_hours', with: attributes[:hours]
        fill_in 'discipline_menu', with: attributes[:menu]
        select "#{period.matrix.name} - #{period.name}", from: 'discipline_period_id'

        submit_form

        expect(page).to have_current_path(admins_disciplines_path)

        expect_page_have_in('table tbody', attributes[:name])
        expect_page_have_in('table tbody', attributes[:code])
        expect_page_have_in('table tbody', period.name)
      end
    end

    context 'when invalid fields' do
      it 'show errors' do
        submit_form

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))
        fields = '%w[div.discipline_name div.discipline_code div.discipline_hours]'
        expect_page_have_blank_messages(fields)
        expect_page_have_in('div.discipline_hours', I18n.t('errors.messages.not_a_number'))
        expect_page_have_in('div.discipline_period', I18n.t('errors.messages.required'))
      end
    end
  end

  describe '#update' do
    let(:discipline) {create(:discipline)}

    before(:each) do
      visit edit_admins_discipline_path(discipline)
    end

    context 'with fields filled' do
      it 'with correct values' do
        expect(page).to have_field 'discipline_name', with: discipline.name
        expect(page).to have_field 'discipline_hours', with: discipline.hours
        expect(page).to have_field 'discipline_code', with: discipline.code

        selected = "#{discipline.period.matrix.name} - #{discipline.period.name}"
        expect(page).to have_select 'discipline_period_id',
                                    selected: selected
      end
    end

    context 'with valid fields' do
      it 'discipline' do
        new_name = 'new name'
        new_code = 'new code'
        new_hours = 70

        fill_in 'discipline_name', with: new_name
        fill_in 'discipline_code', with: new_code
        fill_in 'discipline_hours', with: new_hours
        submit_form

        expect(page).to have_current_path(admins_disciplines_path)
        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.update.f',
                                                   resource_name: resource_name))
        expect_page_have_in('table tbody', new_name)
        expect_page_have_in('table tbody', new_code)
      end
    end

    context 'when invalid fields' do
      it 'show errors' do
        fill_in 'discipline_name', with: ''
        fill_in 'discipline_code', with: ''
        fill_in 'discipline_hours', with: ''
        fill_in 'discipline_menu', with: ''
        submit_form

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))
        fields = '%w[div.discipline_name div.discipline_code div.discipline_hours]'
        expect_page_have_blank_messages(fields)
        expect_page_have_in('div.discipline_hours', I18n.t('errors.messages.not_a_number'))
      end
    end
  end

  describe '#show' do
    let(:discipline) {create(:discipline)}

    it 'show all discipline with options' do
      visit admins_discipline_path(discipline)

      expect(page).to have_content(discipline.name)
      expect(page).to have_content(discipline.code)
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
      click_on_destroy_link(admins_discipline_path(discipline))

      expect_alert_success(resource_name, 'flash.actions.destroy.f')

      expect_page_not_have_in('table tbody', discipline.name)
    end
  end

  describe '#index' do
    let!(:disciplines) {create_list(:discipline, 3)}

    it 'show all discipline with options' do
      visit admins_disciplines_path

      expect(page).to have_link(href: new_admins_discipline_path)

      disciplines.each do |discipline|
        expect(page).to have_content(discipline.name)
        expect(page).to have_content(discipline.code)
        expect(page).to have_content(discipline.period.name)
        expect(page).to have_content(discipline.period.matrix.name)

        expect(page).to have_link(href: edit_admins_discipline_path(discipline))
        expect(page).to have_link(href: admins_discipline_path(discipline))
        expect_page_have_destroy_link(admins_discipline_path(discipline))
      end
    end
  end
end
