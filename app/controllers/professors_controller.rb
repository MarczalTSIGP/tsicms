class ProfessorsController < ApplicationController
  add_breadcrumb I18n.t('breadcrumbs.professors.name'), :professors_path
  def index
    @professors = Professor.order(name: :asc).page params[:page]
  end

  def show
    @professor = Professor.find(params[:id])
    add_breadcrumb I18n.t('breadcrumbs.professors.show', name: "##{@professor.id}"),
                   :professor_path
  end
end
