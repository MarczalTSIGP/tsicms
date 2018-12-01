require 'rails_helper'

RSpec.describe 'Companies', type: :feature do
  let(:admin) {create(:admin)}
  let(:resource_name) {Company.model_name.human}

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

        expect(page).to have_current_path(admins_companies_path)

        expect(page).to have_flash(:success, text: I18n.t('flash.actions.create.f', resource_name: resource_name))

        expect_page_have_in('table tbody', attributes[:name])
      end
    end

    context 'with invalid fields' do
      it 'show errors' do
        submit_form

        expect(page).to have_flash(:danger, text: I18n.t('flash.actions.errors'))

        fields = '%w[div.company_name, div.company_site div.company_operation]'
        expect_page_have_blank_message(fields)
      end
    end
  end

  describe '#update' do
    let(:company) {create :company}

    before(:each) do
      visit edit_admins_company_path(company)
    end

    context 'with valid fields' do
      it 'update company' do
        new_name = 'Empresa Randomica'
        fill_in 'company_name', with: new_name
        submit_form

        expect(page).to have_current_path(admins_company_path(company))
        expect(page).to have_content(new_name.to_s)
      end
    end

    context 'with invalid fields' do
      it 'cannot update company' do
        fill_in 'company_name', with: ''
        submit_form
        expect_page_have_blank_message('div.company_name')
        expect(page).to have_flash(:danger, text: I18n.t('flash.actions.errors'))
      end
    end
  end

  describe '#index' do
    let!(:companies) {create_list(:company, 2)}

    it 'show all companies' do
      visit admins_companies_path

      companies.each do |company|
        expect(page).to have_content(company.name)
        expect(page).to have_content(I18n.l(company.created_at, format: :long))

        expect(page).to have_link(href: admins_company_path(company))
        expect(page).to have_link(href: edit_admins_company_path(company))
        expect_page_have_destroy_link(admins_company_path(company))
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

      expect(page).to have_flash(:success, text: I18n.t('flash.actions.destroy.f', resource_name: resource_name))
      expect_page_not_have_in('table tbody', company.name)
    end
  end
end
