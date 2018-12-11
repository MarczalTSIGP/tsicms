class ActivitiesController < ApplicationController
  add_breadcrumb I18n.t('breadcrumbs.activities.name'), :activities_path

  def index
    @activities = Activity.order(name: :asc).page params[:page]
  end

  def show
    @activity = Activity.find(params[:id])

    add_breadcrumb I18n.t('breadcrumbs.activities.show', name: "##{@activity.id}"),
                   :activity_path
  end
end
