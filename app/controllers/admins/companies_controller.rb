class Admins::CompaniesController < Admins::BaseController
  before_action :set_company, only: [:edit, :update, :destroy, :show]

  add_breadcrumb I18n.t('breadcrumbs.companies.name'), :admins_companies_path
  add_breadcrumb I18n.t('breadcrumbs.companies.new'), :new_admins_company_path,
                 only: [:new, :create]

  def index
    @companies = Company.order(name: :asc).page params[:page]
  end

  def new
    @company = Company.new
  end

  def show
    add_breadcrumb I18n.t('breadcrumbs.companies.show', name: "##{@company.id}"),
                   :admins_company_path
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      feminine_success_create_message
      redirect_to admins_companies_path
    else
      error_message
      render :new
    end
  end

  def edit
    add_breadcrumb I18n.t('breadcrumbs.companies.edit', name: "##{@company.id}"),
                   :edit_admins_company_path
  end

  def update
    if @company.update(company_params)
      feminine_success_update_message
      redirect_to admins_company_path(@company)
    else
      add_breadcrumb I18n.t('breadcrumbs.companies.edit', name: "##{@company.id}"),
                     :edit_admins_company_path

      error_message
      render :edit
    end
  end

  def destroy
    if @company.destroy
      feminine_success_destroy_message
    else
      alert_destroy_bond_message
    end
    redirect_to admins_companies_path
  end

  protected

  def company_params
    params.require(:company).permit(:name,
                                    :site,
                                    :image,
                                    :operation)
  end

  def set_company
    @company = Company.find(params[:id])
  end
end
