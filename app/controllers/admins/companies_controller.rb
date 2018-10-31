class Admins::CompaniesController < Admins::BaseController
  before_action :set_company, only: [:edit, :update, :destroy, :show]

  add_breadcrumb I18n.t('breadcrumbs.companies.name'), :admins_companies_path
  add_breadcrumb I18n.t('breadcrumbs.companies.new'), :new_admins_company_path, only: [:new, :create]

  def index
    @companies = Company.order(name: :asc)
  end

  def new
    @company = Company.new
  end

  def show
    add_breadcrumb I18n.t('breadcrumbs.companies.show', name: "##{@company.id}"),
                   :admins_activity_path
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      flash[:success] = I18n.t('flash.actions.create.f', resource_name: Company.model_name.human)
      redirect_to admins_companies_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :new
    end
  end

  def edit
    add_breadcrumb I18n.t('breadcrumbs.companies.edit', name: "##{@company.id}"),
                   :edit_admins_company_path
  end

  def update
    if @company.update(company_params)
      flash[:success] = I18n.t('flash.actions.update.f', resource_name: Company.model_name.human)
      redirect_to admins_company_path(@company)
    else
      add_breadcrumb I18n.t('breadcrumbs.companies.edit', name: "##{@company.id}"),
                     :edit_admins_company_path

      flash.now[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  def destroy
    if @company.destroy
      flash[:success] = I18n.t('flash.actions.destroy.f',
                               resource_name: Company.model_name.human)
    else
      flash[:alert] = I18n.t('flash.actions.destroy.bond',
                             resource_name: Company.model_name.human)
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
