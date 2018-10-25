class Admins::PeriodsProfessorsController < Admins::BaseController

  add_breadcrumb "Períodos do Professor", :admins_periods_professors_path
  before_action :set_period_professor, only: [:edit, :update, :destroy, :show ]

  def index
    @periods_professors = PeriodProfessor.order(date_entry: :desc)
  end

  def new
    add_breadcrumb "Novo Período", :new_admins_periods_professor_path
    @period_professor = PeriodProfessor.new
  end

  def show
  end

  def edit
    add_breadcrumb "Editar Período", :edit_admins_periods_professor_path
  end

  def update
    if @period_professor.update(period_professor_params)
      flash[:success] = I18n.t('flash.actions.update.m',
                               resource_name: Period.model_name.human)
      redirect_to admins_periods_professors_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  def create
    @period_professor = PeriodProfessor.new(period_professor_params)
    if @period_professor.save
      flash[:success] = I18n.t('flash.actions.create.m',
                               resource_name: Period.model_name.human)
      redirect_to admins_periods_professors_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :new
    end
  end

  def destroy
    @period_professor.destroy
    flash[:success] = I18n.t('flash.actions.destroy.m',
                             resource_name: Period.model_name.human)
    redirect_to admins_periods_professors_path
  end

  private
  def period_professor_params
    params.require(:period_professor).permit(:date_entry, :date_out, :type_contract,:professor)
  end

  def set_period_professor
    @period_professor = PeriodProfessor.find(params[:id])
  end

end
