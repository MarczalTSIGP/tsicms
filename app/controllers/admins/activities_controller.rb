class Admins::ActivitiesController < Admins::BaseController
  before_action :set_activity, only: [:edit, :update, :destroy, :show]

  add_breadcrumb I18n.t('breadcrumbs.activities.name'), :admins_activities_path
  add_breadcrumb I18n.t('breadcrumbs.activities.new'), :new_admins_activity_path,
                 only: [:new, :create]

  def index
    @activities = Activity.order(name: :asc)
  end

  def new
    @activity = Activity.new
  end

  def edit
    add_breadcrumb I18n.t('breadcrumbs.activities.edit', name: "##{@activity.id}"),
                   :edit_admins_activity_path
  end

  def show
    add_breadcrumb I18n.t('breadcrumbs.activities.show', name: "##{@activity.id}"),
                   :admins_activity_path

    store_location
  end

  def create
    @activity = Activity.new(activity_params)

    if @activity.save
      flash[:success] = I18n.t('flash.actions.create.f',
                               resource_name: Activity.model_name.human)
      redirect_to admins_activities_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :new
    end
  end

  def update
    if @activity.update(activity_params)
      flash[:success] = I18n.t('flash.actions.update.f',
                               resource_name: Activity.model_name.human)
      redirect_to admins_activities_path
    else
      add_breadcrumb I18n.t('breadcrumbs.activities.edit', name: "##{@activity.id}"),
                     :edit_admins_activity_path

      flash.now[:error] = I18n.t('flash.actions.errors')
      render :new
    end
  end

  def destroy
    if @activity.destroy
      flash[:success] = I18n.t('flash.actions.destroy.f',
                               resource_name: Activity.model_name.human)
    else
      flash[:alert] = 'Não é possível remover atividades que
      possuem professores vinculados!'
    end
    redirect_to admins_activities_path
  end

  protected

  def activity_params
    params.require(:activity).permit(:name,
                                     :description)
  end

  def set_activity
    @activity = Activity.find(params[:id])
  end
end
