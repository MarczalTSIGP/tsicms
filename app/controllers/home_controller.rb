class HomeController < ApplicationController
  def index
    @discipline_monitors = DisciplineMonitor.order(year: :desc, semester: :desc)
    @faqs = Faq.order(created_at: :desc)
    @trainees = Trainee.order(created_at: :desc)
    @companies = Company.order(created_at: :desc)
    @cp = Professor.all.group_by { |p| p.professor_category.name }
  end
end
