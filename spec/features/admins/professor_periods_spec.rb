require 'rails_helper'

RSpec.describe 'Professor Periods', type: :feature do
  let(:admin) { create(:admin) }
  let(:professor) { create(:professor) }
  let(:resource_name) { ProfessorPeriod.model_name.human }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  describe '#create' do
    let!(:category) { create_list(:professor_category, 2).sample }

    before(:each) do
      visit new_admins_professor_professor_period_path(professor)
    end

    context 'with valid fields' do
      it 'add teacher work periods with date of entry and exit' do
        attributes = attributes_for(:professor_period)

        select '1', from: 'professor_period[date_entry(3i)]'
        select 'Janeiro', from: 'professor_period[date_entry(2i)]'
        select '2018', from: 'professor_period[date_entry(1i)]'

        select '10', from: 'professor_period[date_out(3i)]'
        select 'Junho', from: 'professor_period[date_out(2i)]'
        select '2018', from: 'professor_period[date_out(1i)]'
        select category.name, from: 'professor_period_professor_category_id'

        submit_form

        expect(page).to have_current_path(admins_professor_path(professor))

        expect_alert_success(resource_name, 'flash.actions.create.m')

        expect_page_have_in('table#professor_periods tbody', attributes[:name])
      end
    end

    context 'with invalid fields' do
      it 'show errors' do
        submit_form
        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))
        expect_page_have_in('div.professor_period_date_entry',
                            I18n.t('errors.messages.blank'))
        have_contains('div.professor_period_professor_category',
                      I18n.t('errors.messages.blank'))
      end
    end
  end

  describe '#update professor period' do
    let!(:professor_period) { create(:professor_period) }

    before(:each) do
      visit edit_admins_professor_professor_period_path(
        professor_period.professor, professor_period
      )
    end

    it 'with incorrect values' do
      select '22', from: 'professor_period[date_entry(3i)]'
      select 'Janeiro', from: 'professor_period[date_entry(2i)]'
      select '2018', from: 'professor_period[date_entry(1i)]'

      select '20', from: 'professor_period[date_out(3i)]'
      select 'Janeiro', from: 'professor_period[date_out(2i)]'
      select '2018', from: 'professor_period[date_out(1i)]'

      submit_form

      expect(page).to have_selector('div.alert.alert-danger',
                                    text: I18n.t('flash.actions.errors'))
      expect_page_have_in('div.professor_period_date_entry',
                          I18n.t('errors.messages.date.less_thee'))
    end
  end

  describe '#destroy' do
    let!(:professor_period) { create(:professor_period) }

    it 'destroy professor period' do
      visit admins_professor_path(professor_period.professor)

      destroy_path = "/administradores/professores/#{professor_period
                      .professor.id}/professor_periods/#{professor_period.id}"
      click_link href: destroy_path

      expect(page).to have_selector('div.alert.alert-success',
                                    text: I18n.t('flash.actions.destroy.m',
                                                 resource_name: resource_name))

      within('table#professor_periods tbody') do
        expect(page).not_to have_content(professor_period.id)
      end
    end
  end
end
