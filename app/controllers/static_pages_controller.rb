class StaticPagesController < ApplicationController

  def index
    @static_page = StaticPage.find_by!(permalink: params[:permalink])
  end

  def trainee
    find_static_page 'Estágio'
    @trainees = Trainee.order(created_at: :desc)
  end

  def tcc
    find_static_page 'TCC'
  end

  def monitor
    find_static_page 'Monitoria'
  end

  def professor
    @professor = Professor.find(params[:id])
  end

  def company
    @company = Company.find(params[:id])
  end

  def activity
    @activity = Activity.find(params[:id])
  end

  def history
    @activity_professors = Activity.find_by(name: 'Estagio').activity_professors.page params[:page]
    @static_page = StaticPage.find(params[:static_page_id])
    add_breadcrumb I18n.t('breadcrumbs.static_pages.historic', name: "##{@static_page.id}"),
                   :static_page_history_path
  end

  private

  def find_static_page(title)
    @static_page = StaticPage.find_by!(title: title)
  end
end
