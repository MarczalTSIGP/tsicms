class Admins::ProfessorController < Admins::BaseController

  def index
    @professors = Professor.all
  end

end
