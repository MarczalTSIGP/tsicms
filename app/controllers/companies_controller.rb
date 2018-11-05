class CompaniesController < ApplicationController
  add_breadcrumb I18n.t('breadcrumbs.companies.name'), :companies_path
  def index
    @companies = Company.order(name: :asc).page params[:page]
  end

  def show
    @company = Company.find(params[:id])
    add_breadcrumb I18n.t('breadcrumbs.companies.show', name: "##{@company.id}"),
                   :company_path
  end
end
