class StaticPagesController < ApplicationController
  skip_around_action :set_locale_from_url
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

  private

  def find_static_page(title)
    @static_page = StaticPage.find_by!(title: title)
  end
end
