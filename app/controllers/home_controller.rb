class HomeController < ApplicationController
  def index
    @discipline_monitors = DisciplineMonitor.order(year: :desc, semester: :desc)
    @faqs = Faq.order(created_at: :desc)
    @trainees = Trainee.order(created_at: :desc)
    @companies= Company.order(created_at: :desc)
    @efetive_professors = ProfessorCategory.find_by(name: 'Efetivo').professors.order(name: :asc)
    @temporary_professors = ProfessorCategory.find_by(name: 'Temporário').professors.order(name: :asc)
  end
end
