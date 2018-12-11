require 'rails_helper'

RSpec.describe 'Professor Periods', type: :feature do
  let(:admin) { create(:admin) }
  let(:professor){ create(:professor) }
  let(:resource_name) { ProfessorPeriod.model_name.human }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  describe '#create' do
    before(:each) do
      @category = create_list(:professor_category, 2).sample
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
        select @category.name, from: 'professor_period_professor_category_id'
        submit_form
        expect(page.current_path).to eq admins_professor_path(professor)
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
  endData de entrada deve menor que a data de saída!


  describe '#update professor period' do

      before(:each) do
        @professor_period = create(:professor_period)
        visit edit_admins_professor_professor_period_path(@professor_period.professor, @professor_period)
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
end
