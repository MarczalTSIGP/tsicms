class StaticPagesController < ApplicationController
  def index
    @static_page = StaticPage.find_by(permalink: params[:permalink])
    @static_page = StaticPage.find_by!(id: params[:permalink]) if @static_page.nil?
    find_trainees if @static_page.title.include? I18n.t('helpers.trainee')
  end

  def history
    @static_page = StaticPage.find(params[:static_page_id])
    @activity_professors = @static_page.activity.activity_professors.page params[:page]

    add_breadcrumb I18n.t('breadcrumbs.static_pages.historic', name: "##{@static_page.id}"),
                   :static_page_history_path
  end

  def vacancy
    @static_page = StaticPage.find(params[:static_page_id])
    @trainee = Trainee.find(params[:vacancy_id])
    add_breadcrumb I18n.t('breadcrumbs.trainees.show', name: "##{@trainee.id}"),
                   :static_page_vacancy_path
  end

  private

  def find_professor_responsible
    @professor = @static_page.activity.current_responsible
  end

  def find_trainees
    @trainees = Trainee.order(title: :asc).page params[:page]
  end
end
