class Admins::ProfessorController < Admins::BaseController

  def index
    @professors = Professor.all
  end

  def new
    @professor = Professor.new
  end

  def create
    @professor = Professor.new(params[:professor])
    if @professor.save
      redirect_to @professor
    else
      redirect_to 'new'
    end
  end

  def edit;
  end

  def update;
  end

  def show
    puts params[:id]
    @professor = Professor.find(params[:id])
  end
end
