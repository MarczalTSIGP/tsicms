class Admins::PeriodsProfessorsController < Admins::BaseController
  before_action :set_period_professor, only: [:edit, :update, :destroy, :show]

  #add_breadcrumb I18n.t('breadcrumbs.periods_professors.name'), :admins_periods_professors_path
  #add_breadcrumb I18n.t('breadcrumbs.periods_professors.new'), :new_admins_periods_professors_path, only: [:new, :create]

  # Breadcrumbs teria que ficar Pagina Inicial / Professor:(id) / Periodo do Professor / Novo Periodo

  def new
    @professor = Professor.find(params[:professor_id])
    @period_professor = @professor.period_professors.new
  end

  def edit
  
  end

  def update
    @professor = Professor.find(params[:professor_id])
    
    if @period_professor.update(period_professor_params)
      flash[:success] = I18n.t('flash.actions.update.m',
                               resource_name: Period.model_name.human)
      redirect_to admins_professor_path(@professor)
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  def create
    @professor = Professor.find(params[:professor_id])
    @period_professor = @professor.period_professors.new(period_professor_params)
    if @period_professor.save
      flash[:success] = I18n.t('flash.actions.create.m',
                               resource_name: PeriodProfessor.model_name.human)
      redirect_to admins_professor_path(@professor)
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :new
    end
  end

  def destroy
    @period_professor = @professor.period_professors.find(params[:id])
    @period_professor.destroy
    flash[:success] = I18n.t('flash.actions.destroy.m',
                             resource_name: Period.model_name.human)
    redirect_to admins_professor_path(@professor)
  end

  private
  def period_professor_params
    params.require(:period_professor).permit(:date_entry, :date_out, :professor_id,:professor_category_id)
  end
  
  def set_period_professor
    @professor = Professor.find(params[:professor_id])
  end

end
