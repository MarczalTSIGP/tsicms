class Admins::ActivityProfessorsController < Admins::BaseController
  before_action :set_activity_professor, only: [:edit, :update, :destroy]

  def new
    @activity_professor = ActivityProfessor.new
    @activity_professor.professor = params[:professor]
  end

  def create
    @activity_professor = ActivityProfessor.new(activity_professor_params)
    if @activity_professor.save
      flash[:success] = I18n.t('flash.actions.create.f', resource_name: ActivityProfessor.model_name.human)
      redirect_to admins_professor_path(@activity_professor.professor)
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :new
    end
  end

  def edit;
  end

  def update
    if @activity_professor.update(activity_professor_params)
      flash[:success] = I18n.t('flash.actions.update.f', resource_name: ActivityProfessor.model_name.human)
      redirect_to admins_professor_path(@activity_professor.professor)
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  def destroy
    @activity_professor.destroy
    flash[:success] = I18n.t('flash.actions.destroy.f', resource_name: ActivityProfessor.model_name.human)
    redirect_to admins_professors_path
  end

  protected

  def activity_professor_params
    params.require(:activity_professor).permit(:professor_id,
                                               :activity_id,
                                               :start_date,
                                               :end_date)
  end

  def set_activity_professor
    @activity_professor = ActivityProfessor.find(params[:id])
  end
end
