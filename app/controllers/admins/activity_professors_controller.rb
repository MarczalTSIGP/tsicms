class Admins::ActivityProfessorsController < Admins::BaseController
  before_action :set_activity_professor, only: [:edit, :update, :destroy]

  add_breadcrumb I18n.t('breadcrumbs.activity_professors.name'), :admins_activities_path
  add_breadcrumb I18n.t('breadcrumbs.activity_professors.new'),
                 :new_admins_activity_professor_path, only: [:new, :create]

  def new
    @activity_professor = ActivityProfessor.new
    add_professor(params[:professor])
    add_activity(params[:activity])
  end

  def create
    @activity_professor = ActivityProfessor.new(activity_professor_params)
    if @activity_professor.save
      feminine_success_create_message
      redirect_back_or(admins_activities_path)
    else
      error_message
      render :new
    end
  end

  def edit
    add_breadcrumb I18n.t('breadcrumbs.activity_professors.edit'),
                   :edit_admins_activity_professor_path
  end

  def show
    add_breadcrumb I18n.t('breadcrumbs.activity_professors.show'), :admins_activity_professor_path
  end

  def update
    if @activity_professor.update(activity_professor_params)
      feminine_success_update_message
      redirect_back_or(admins_activities_path)
    else
      add_breadcrumb I18n.t('breadcrumbs.activity_professors.edit'),
                     :edit_admins_activity_professor_path

      error_message
      render :edit
    end
  end

  def destroy
    @activity_professor.destroy

    feminine_success_destroy_message
    redirect_back_or(admins_activities_path)
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

  private

  def add_professor(professor_id)
    return unless professor_id

    @professor = Professor.find(professor_id)
    @activity_professor.professor = @professor if @professor
  end

  def add_activity(activity_id)
    return unless activity_id

    @activity = Activity.find(activity_id)
    @activity_professor.activity = @activity if @activity
  end
end
