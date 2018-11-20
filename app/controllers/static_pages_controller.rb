class StaticPagesController < ApplicationController

  def index
    @static_page = StaticPage.find_by!(permalink: params[:permalink])
  end

  def tcc
    find_static_page I18n.t('helpers.tcc')
    find_professor_responsible I18n.t('helpers.tcc')
  end

  def monitor
    find_static_page I18n.t('helpers.monitor')
    find_professor_responsible I18n.t('helpers.monitor')
  end

  def history
    @static_page = StaticPage.find(params[:static_page_id])

    @activity_professors = Activity.activity_professors(@static_page.title).page params[:page]

    add_breadcrumb I18n.t('breadcrumbs.static_pages.historic', name: "##{@static_page.id}"),
                   :static_page_history_path
  end

  private

  def find_professor_responsible(title)
    @professor = Activity.current_responsible(title)
  end

  def find_static_page(title)
    @static_page = StaticPage.find_by!(title: title)
  end
end
