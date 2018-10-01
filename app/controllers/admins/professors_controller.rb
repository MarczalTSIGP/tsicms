class Admins::ProfessorsController < Admins::BaseController
  before_action :set_professor, only: [:edit, :update, :destroy, :show]

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

  def edit; end

  def update
    if @professor.update(professor_params)
      flash[:success] = I18n.t('flash.actions.update.m', resource_name: Professor.model_name.human)
      redirect_to admins_professor_path(@professor)
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  def destroy
    @professor.destroy
    flash[:success] = I18n.t('flash.actions.destroy.m', resource_name: Professor.model_name.human)
    redirect_to admins_professors_path
  end

  def show; end

  protected

  def professor_params
    params.require(:professor).permit(:name,
                                      :lattes,
                                      :occupation_area,
                                      :email,
                                      :professor_title_id,
                                      :professor_category_id)
  end

  def set_professor
    @professor = Professor.find(params[:id])
  end
end
