class DisciplineMonitorsController < ApplicationController
  def index
    @discipline_monitors = DisciplineMonitor.order(year: :desc, semester: :desc)
  end

  def show
    @discipline_monitor = DisciplineMonitor.find(params[:id])
  end
end

