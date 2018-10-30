class Admins::CompaniesController < Admins::BaseController
  before_action :set_company, only: [:edit, :update, :destroy, :show]

  def index
    @companies = Company.order(name: :asc)
  end

  def new
    @company = Company.new
  end

  def show;
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

  def edit;
  end

  def update
    if @company.update(company_params)
      flash[:success] = I18n.t('flash.actions.update.f', resource_name: Company.model_name.human)
      redirect_to admins_company_path(@company)
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  def destroy
    if @company.destroy
      flash[:success] = I18n.t('flash.actions.destroy.f',
                               resource_name: Company.model_name.human)
    else
      flash[:alert] = 'Não é possível remover Empresas com vínculos!'
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
