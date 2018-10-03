require 'rails_helper'

RSpec.feature 'Period', type: :feature do

  let(:admin) { create(:admin) }
  let!(:matrix) { create_list(:matrix, 3).sample }
  let(:resource_name) { Period.model_name.human }

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

        expect(page.current_path).to eq admins_periods_path

        
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

        within('div.period_name') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
      end
    end

    context 'when has same name'  do
      let(:period) { create(:period) }

      it 'show errors' do
        fill_in 'period_name', with: period.name
        submit_form

        within('div.period_name') do
          expect(page).to have_content(I18n.t('errors.messages.taken'))
        end
      end

      it 'show errors considering insensitive case' do
        fill_in 'period_name', with: period.name.downcase
        submit_form

        within('div.period_name') do
          expect(page).to have_content(I18n.t('errors.messages.taken'))
        end
      end
    end
  end

  describe '#update' do
    let(:period) { create(:period) }

    before(:each) do
      visit edit_admins_period_path(period)
    end

    context 'fill fields' do
      it 'with correct values' do
        expect(page).to have_field 'period_name', with: period.name
      end
    end

    context 'with valid fields' do
      it 'update period' do
        new_name = '2Periodo'
        fill_in 'period_name', with: new_name

        submit_form

        expect(page.current_path).to eq admins_periods_path

        expect(page).to have_selector('div.alert.alert-success',
                                     text: I18n.t('flash.actions.update.m',
                                                  resource_name: resource_name))

        within('table tbody') do
          expect(page).to have_content(new_name)
        end
      end
    end

    context 'when invalid fields' do
      it 'show errors' do
        fill_in 'period_name', with: ''
        submit_form

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))

        within('div.period_name') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
      end
    end

    context 'when has same name'  do
      let(:other_period) { create(:period) }

      it 'show errors' do
        fill_in 'period_name', with: other_period.name
        submit_form

        within('div.period_name') do
          expect(page).to have_content(I18n.t('errors.messages.taken'))
        end
      end

      it 'show errors cosidering insensitive case' do
        fill_in 'period_name', with: other_period.name.downcase
        submit_form

        within('div.period_name') do
          expect(page).to have_content(I18n.t('errors.messages.taken'))
        end
      end
    end
  end

  describe '#destroy' do
    it 'period' do
      period = create(:period)
      visit admins_periods_path

      destroy_link = "a[href='#{admins_period_path(period)}'][data-method='delete']"
      find(destroy_link).click

      expect(page).to have_selector('div.alert.alert-success',
                                    text: I18n.t('flash.actions.destroy.m',
                                                resource_name: resource_name))

      within('table tbody') do
        expect(page).not_to have_content(period.name)
      end
    end
  end

  describe '#index' do
    let!(:periods) { create_list(:period, 3) }

    it 'show all period with options' do
      visit admins_periods_path

      periods.each do |period|
        expect(page).to have_content(period.name)
        expect(page).to have_content(period.created_at)

        expect(page).to have_link(href: edit_admins_period_path(period))
        destroy_link = "a[href='#{admins_period_path(period)}'][data-method='delete']"
        expect(page).to have_css(destroy_link)
      end
    end 
  end

end
