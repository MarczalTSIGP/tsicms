class Admins::ActivitiesController < Admins::BaseController

  before_action :set_activity, only: [:edit, :update, :destroy]

  def index
    @activities = Activity.order(name: :asc)
  end

  def new
    @activity = Activity.new
  end

  def edit;
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
      flash[:success] = I18n.t('flash.actions.update.m', resource_name: Activity.model_name.human)
      redirect_to admins_activities_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :new
    end
  end

  def destroy
    @activity.destroy
    flash[:success] = I18n.t('flash.actions.destroy.m', resource_name: Activity.model_name.human)
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
