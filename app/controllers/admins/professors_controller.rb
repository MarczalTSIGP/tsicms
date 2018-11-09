class Admins::ProfessorsController < Admins::BaseController
  before_action :set_professor, only: [:edit, :update, :destroy, :show]

  add_breadcrumb I18n.t('breadcrumbs.professors.name'), :admins_professors_path
  add_breadcrumb I18n.t('breadcrumbs.professors.new'), :new_admins_professor_path,
                 only: [:new, :create]

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

  def edit
    add_breadcrumb I18n.t('breadcrumbs.professors.edit', name: "##{@professor.id}"),
                   :edit_admins_professor_path
  end

  def update
    if @professor.update(professor_params)
      flash[:success] = I18n.t('flash.actions.update.m', resource_name: Professor.model_name.human)
      redirect_to admins_professor_path(@professor)
    else
      add_breadcrumb I18n.t('breadcrumbs.professors.edit', name: "##{@professor.id}"),
                     :edit_admins_professor_path

      flash.now[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  def destroy
    if @professor.destroy
      flash[:success] = I18n.t('flash.actions.destroy.m',
                               resource_name: Professor.model_name.human)
    else
      flash[:alert] = 'Não é possível remover professores com vínculos!'
    end
    redirect_to admins_professors_path
  end

  def show
    add_breadcrumb I18n.t('breadcrumbs.professors.show', name: "##{@professor.id}"),
                   :admins_professor_path
    store_location
  end

  protected

  def professor_params
    params.require(:professor).permit(:name,
                                      :lattes,
                                      :occupation_area,
                                      :gender,
                                      :image,
                                      :image_cache,
                                      :email,
                                      :professor_title_id,
                                      :professor_category_id)
  end

  def set_professor
    @professor = Professor.find(params[:id])
  end
end
