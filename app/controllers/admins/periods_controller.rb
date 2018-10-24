class Admins::PeriodsController < Admins::BaseController

  add_breadcrumb "Períodos", :admins_periods_path

  before_action :set_period, only: [:edit, :update, :destroy, :show ]

  def index
    @periods = Period.includes(:matrix).
      order('matrices.name ASC', 'periods.name ASC')
  end

  def new
    add_breadcrumb "Novo Período", :new_admins_period_path
    @period = Period.new
  end

  def show
  end

  def edit
    add_breadcrumb "Editar Período: #{@period.name}", :edit_admins_period_path
  end

  def update
    if @period.update(period_params)
      flash[:success] = I18n.t('flash.actions.update.m',
                               resource_name: Period.model_name.human)

      redirect_to admins_periods_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  def create
    @period = Period.new(period_params)
    if @period.save
      flash[:success] = I18n.t('flash.actions.create.m',
                               resource_name: Period.model_name.human)
      redirect_to admins_periods_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :new
    end
  end

  def destroy
    @period.destroy
    flash[:success] = I18n.t('flash.actions.destroy.m',
                             resource_name: Period.model_name.human)
    redirect_to admins_periods_path
  end

  private
  def period_params
    params.require(:period).permit(:name, :matrix_id)
  end

  def set_period
    @period = Period.find(params[:id])
  end
end
