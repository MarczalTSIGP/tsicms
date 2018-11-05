class TraineesController < ApplicationController
  add_breadcrumb I18n.t('breadcrumbs.trainees.name'), :trainees_path
  def index
    @static_page = StaticPage.find_by!(title: I18n.t('helpers.trainee'))
    @trainees = Trainee.order(title: :asc).page params[:page]
  end

  def show
    @trainee = Trainee.find(params[:id])
    add_breadcrumb I18n.t('breadcrumbs.trainees.show', name: "##{@trainee.id}"),
                   :trainee_path
  end
end
