class HomeController < ApplicationController
  def index
    @discipline_monitors = DisciplineMonitor.order(year: :desc, semester: :desc)
  end
end
