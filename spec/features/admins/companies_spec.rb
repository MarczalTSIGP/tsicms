require 'rails_helper'

RSpec.feature 'Companies', type: :feature do
  let(:admin) { create(:admin) }
  let(:resource_name) { Company.model_name.human }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  describe '#create' do
    before(:each) do
      visit new_admins_company_path
    end
    context 'with valid fields' do
      it 'create company' do
        attributes = attributes_for(:company)

        fill_in 'company_name', with: attributes[:name]
        fill_in 'company_site', with: attributes[:site]
        fill_in 'company_operation', with: attributes[:operation]

        submit_form

        expect(page.current_path).to eq admins_companies_path

        expect_alert_success(resource_name, 'flash.actions.create.f')

        expect_page_have_in('table tbody', attributes[:name])
      end
    end
    context 'with invalid fields' do
      it 'show errors' do
        submit_form

        expect_alert_error('flash.actions.errors')

        expect_page_have_in('div.company_name', I18n.t('errors.messages.blank'))
        expect_page_have_in('div.company_site', I18n.t('errors.messages.blank'))
        expect_page_have_in('div.company_operation', I18n.t('errors.messages.blank'))
      end
    end
  end

  describe '#update' do
    let(:company) { create :company }
    before(:each) do
      visit edit_admins_company_path(company)
    end
    context 'with valid fields' do
      it 'update company' do
        new_name = 'Empresa Randomica'
        fill_in 'company_name', with: new_name
        submit_form

        expect(page.current_path).to eq admins_company_path(company)
        expect(page).to have_content(new_name.to_s)
      end
    end
    context 'with invalid fields' do
      it 'cannot update company' do
        fill_in 'company_name', with: ''
        submit_form
        expect_page_have_in('div.company_name', I18n.t('errors.messages.blank'))
        expect_alert_error('flash.actions.errors')
      end
    end
  end

  describe '#index' do
    let!(:companies) { create_list(:company, 2) }

    it 'show all companies' do
      visit admins_companies_path

      companies.each do |company|
        expect(page).to have_content(company.name)
        expect(page).to have_content(I18n.l(company.created_at, format: :long))

        expect(page).to have_link(href: admins_company_path(company))
        expect(page).to have_link(href: edit_admins_company_path(company))
        destroy_link = "a[href='#{admins_company_path(company)}'][data-method='delete']"
        expect(page).to have_css(destroy_link)
      end
    end
    it 'show company page' do
      company = create(:company)
      visit admins_company_path(company)

      expect(page).to have_content(company.name)
      expect(page).to have_content(company.operation)
      expect(page).to have_content(company.site)
    end
  end

  describe '#destroy' do
    it 'company' do
      company = create(:company)
      visit admins_companies_path

      click_on_destroy_link(admins_company_path(company))

      expect_alert_success(resource_name, 'flash.actions.destroy.f')

      expect_page_not_have_in('table tbody', company.name)
    end
  end
end
