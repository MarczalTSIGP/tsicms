class Admins::PeriodsController < Admins::BaseController
  before_action :set_period, only: [:edit, :update, :destroy, :show]

  add_breadcrumb I18n.t('breadcrumbs.periods.name'), :admins_periods_path
  add_breadcrumb I18n.t('breadcrumbs.periods.new'), :new_admins_period_path, only: [:new, :create]

  def index

    @periods = Period.includes(:matrix)
                     .order('matrices.name ASC', 'periods.name ASC').page params[:page]
  end

  def new
    @period = Period.new
  end

  def show
    add_breadcrumb I18n.t('breadcrumbs.periods.show', name: "##{@period.id}"),
                   :admins_period_path
  end

  def edit
    add_breadcrumb I18n.t('breadcrumbs.periods.edit', name: "##{@period.id}"),
                   :edit_admins_period_path
  end

  def update
    if @period.update(period_params)
      success_update_message
      redirect_to admins_periods_path
    else
      add_breadcrumb I18n.t('breadcrumbs.periods.edit', name: "##{@period.id}"),
                     :edit_admins_period_path

      error_message
      render :edit
    end
  end

  def create
    @period = Period.new(period_params)
    if @period.save
      success_create_message
      redirect_to admins_periods_path
    else
      error_message
      render :new
    end
  end

  def destroy
    @period.destroy
    success_destroy_message
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
