class Admins::ProfessorPeriodsController < Admins::BaseController
  before_action :set_professor
  before_action :set_period, only: [:edit, :update]

  add_breadcrumb I18n.t('breadcrumbs.professors.name'), :admins_professors_path
  
  def new
    add_breadcrumb I18n.t('breadcrumbs.professors.show', 
                    name: "##{@professor.id}"), admins_professor_path(@professor)
    add_breadcrumb I18n.t('breadcrumbs.professors.newperiod'), 
                    :new_admins_professor_professor_period_path, only: [:new, :create]
    @period = @professor.periods.new
  end

  def edit
    add_breadcrumb I18n.t('breadcrumbs.professors.show', 
                    name: "##{@professor.id}"), admins_professor_path(@professor)
    add_breadcrumb I18n.t('breadcrumbs.professors.editperiod'), 
                    :edit_admins_professor_professor_period_path
    @period = @professor.periods.find(params[:id])
  end

  def create
    @period = @professor.periods.new(period_params)
    if @period.save
      flash[:success] = I18n.t('flash.actions.create.m',
                               resource_name: ProfessorPeriod.model_name.human)
      redirect_to admins_professor_path(@professor)
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :new
    end
  end

  def destroy
    @period = @professor.periods.find(params[:id])
    @period.destroy
    flash[:success] = I18n.t('flash.actions.destroy.m',
                             resource_name: ProfessorPeriod.model_name.human)
    redirect_to admins_professor_path(@professor)
  end

  def update
    if @period.update(period_params)
      flash[:success] = I18n.t('flash.actions.update.m',
                               resource_name: ProfessorPeriod.model_name.human)
      redirect_to admins_professor_path(@professor)
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  private

  def period_params
    params.require(:professor_period).permit(:date_entry, :date_out, 
                                            :professor_id, :professor_category_id)
  end
  
  def set_professor
    @professor = Professor.find(params[:professor_id])
  end

  def set_period
    @period = @professor.periods.find(params[:id])
  end

end