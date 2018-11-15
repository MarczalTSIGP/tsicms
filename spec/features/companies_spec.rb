require 'rails_helper'

RSpec.feature 'Companies Public Page', type: :feature do

  describe '#show' do
    let!(:companies) {create_list(:company, 6)}
    it 'all companies' do
      visit companies_path

      companies.each do |company|
        expect(page).to have_content(company.name)
        expect(page).to have_content(I18n.l(company.created_at, format: :long))
        expect(page).to have_link(href: company_path(company))
      end
    end
    it 'company page' do
      company = companies.first
      visit company_path(company)
      expect(page).to have_content(company.name)
      expect(page).to have_content(company.operation)
      expect(page).to have_content(company.site)
    end
  end
end
