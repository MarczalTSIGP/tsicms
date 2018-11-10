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
      feminine_success_create_message
      redirect_to admins_activities_path
    else
      error_message
      render :new
    end
  end

  def update
    if @activity.update(activity_params)
      feminine_success_update_message
      redirect_to admins_activities_path
    else
      add_breadcrumb I18n.t('breadcrumbs.activities.edit', name: "##{@activity.id}"),
                     :edit_admins_activity_path

      error_message
      render :new
    end
  end

  def destroy
    if @activity.destroy
      feminine_success_destroy_message
    else
      alert_destroy_bond_message
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
