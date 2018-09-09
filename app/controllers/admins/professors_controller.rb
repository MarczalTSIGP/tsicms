class Admins::ProfessorsController < Admins::BaseController

  before_action :mount_professor, only: [:edit, :new, :show]

  def index
    @professors = Professor.all
  end

  def new;
  end

  def create
    @professor = Professor.new(params[:professors])
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

  def destroy
    Professor.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to 'index', notice: 'Professor removido com sucesso!' }
      format.json { head :no_content }
    end
  end

  def show;
  end

  private def mount_professor
    @professor = if params[:id].nil?
                   Professor.new
                 else
                   Professor.find(params[:id])
                 end
  end
end
