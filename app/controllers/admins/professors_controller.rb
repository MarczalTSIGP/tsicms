class Admins::ProfessorsController < Admins::BaseController

  before_action :mount_professor, only: [:edit, :new, :show]

  def index
    @professors = Professor.all
  end

  def new
    @professor = Professor.new
  end

  def create
    @professor = Professor.new(professor_params)
    if @professor.save
      redirect_to admins_professor_path(@professor)
    else
      redirect_to new_admins_professor_path
    end
  end

  def edit;
  end

  def update
    @professor = find_user
    if @professor.update_attributes(professor_params)
      redirect_to admins_professor_path(@professor)
    else
      render edit_admins_professor_path(@professor)
    end
  end

  def destroy
    find_user.destroy
    respond_to do |format|
      format.html { redirect_to 'index', notice: 'Professor removido com sucesso!' }
      format.json { head :no_content }
    end
  end

  def show;
  end


  private

  def mount_professor
    @professor = if params[:id].nil?
                   Professor.new
                 else
                   find_user
                 end
  end

  def professor_params
    params.require(:professor).permit(:name, :lattes, :occupation_area, :email)
  end

  def find_user
    Professor.find(params[:id])
  end
end