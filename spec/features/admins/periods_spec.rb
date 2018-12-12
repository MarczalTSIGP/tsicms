require 'rails_helper'

RSpec.describe 'Period', type: :feature do
  let(:admin) { create(:admin) }
  let!(:matrix) { create_list(:matrix, 3).sample }
  let(:resource_name) { Period.model_name.human }
  let!(:period) { create(:period) }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  describe '#create' do
    before(:each) do
      visit new_admins_period_path
    end

    context 'with valid fields' do
      it 'create period' do
        attributes = attributes_for(:period)

        fill_in 'period_name', with: attributes[:name]
        select matrix.name, from: 'period_matrix_id'
        submit_form

        expect(page).to have_current_path(admins_periods_path)

        expect_page_have_in('table tbody', attributes[:name])
      end
    end

    context 'when invalid fields' do
      it 'show errors' do
        submit_form

        expect(page).to have_flash(:danger, text: I18n.t('flash.actions.errors'))

        expect_page_blank_message('div.period_name')
        expect_page_have_in('div.period_matrix', I18n.t('errors.messages.required'))
      end
    end

    context 'when has same name to same matrix' do
      let(:period) { create(:period, matrix: matrix) }

      it 'show errors' do
        fill_in 'period_name', with: period.name
        select matrix.name, from: 'period_matrix_id'
        submit_form

        expect_page_have_in('div.period_name', I18n.t('errors.messages.taken'))
      end

      it 'show errors considering insensitive case' do
        fill_in 'period_name', with: period.name.downcase
        select matrix.name, from: 'period_matrix_id'
        submit_form

        expect_page_have_in('div.period_name', I18n.t('errors.messages.taken'))
      end
    end
  end

  describe '#update' do
    before(:each) do
      visit edit_admins_period_path(period)
    end

    context 'with filled fields' do
      it 'with correct values' do
        expect(page).to have_field 'period_name', with: period.name
      end
    end

    context 'with valid fields' do
      it 'update period' do
        new_name = '2Periodo'
        fill_in 'period_name', with: new_name

        submit_form

        expect(page).to have_current_path(admins_periods_path)
        text = I18n.t('flash.actions.update.m', resource_name: resource_name)
        expect(page).to have_flash(:success, text: text)

        expect_page_have_in('table tbody', new_name)
      end
    end

    context 'when invalid fields' do
      it 'show errors' do
        fill_in 'period_name', with: ''
        submit_form

        expect(page).to have_flash(:danger, text: I18n.t('flash.actions.errors'))

        expect_page_blank_message('div.period_name')
      end
    end

    context 'when has same name' do
      let(:other_period) { create(:period, matrix: matrix) }

      it 'show errors' do
        fill_in 'period_name', with: other_period.name
        select matrix.name, from: 'period_matrix_id'
        submit_form

        expect_page_have_in('div.period_name', I18n.t('errors.messages.taken'))
      end

      it 'show errors cosidering insensitive case' do
        fill_in 'period_name', with: other_period.name.downcase
        select matrix.name, from: 'period_matrix_id'
        submit_form
        expect_page_have_in('div.period_name', I18n.t('errors.messages.taken'))
      end
    end
  end

  describe '#index' do
    let!(:periods) { create_list(:period, 3) }

    it 'show all period with options' do
      visit admins_periods_path

      periods.each do |period|
        expect(page).to have_content(period.name)
        expect(page).to have_content(I18n.l(period.created_at, format: :long))

        expect(page).to have_link(href: edit_admins_period_path(period))
        expect_page_have_destroy_link(admins_period_path(period))
      end
    end
  end

  describe '#destroy' do
    it 'period' do
      visit admins_periods_path

      click_on_destroy_link(admins_period_path(period))
      text = I18n.t('flash.actions.destroy.m', resource_name: resource_name)
      expect(page).to have_flash(:success, text: text)
      expect_page_not_have_in('table tbody', period.name)
    end
  end
end
