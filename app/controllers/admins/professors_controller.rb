class Admins::ProfessorsController < Admins::BaseController
  before_action :mount_professor, only: [:edit, :new, :show]

  def index
    @professors = Professor.order(name: :asc)
  end

  def new
    @professor = Professor.new
  end

  def create
    @professor = Professor.new(professor_params)
    if @professor.save
      flash[:success] = I18n.t('flash.actions.create.m', resource_name: Professor.model_name.human)
      redirect_to admins_professors_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :new
    end
  end

  def edit;
  end

  def update
    @professor = find_user
    if @professor.update_attributes(professor_params)
      flash[:success] = I18n.t('flash.actions.update.m', resource_name: Professor.model_name.human)
      redirect_to admins_professor_path(@professor)
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  def destroy
    find_user.destroy
    flash[:success] = I18n.t('flash.actions.destroy.m', resource_name: Professor.model_name.human)
    redirect_to admins_professors_path
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
    params.require(:professor).permit(:name,
                                      :lattes,
                                      :occupation_area,
                                      :email,
                                      :professor_title_id,
                                      :professor_category_id)
  end

  def find_user
    Professor.find(params[:id])
  end
end
