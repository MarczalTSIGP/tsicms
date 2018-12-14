class Admins::ProfessorsController < Admins::BaseController
  before_action :set_professor, only: [:edit, :update, :destroy, :show]

  add_breadcrumb I18n.t('breadcrumbs.professors.name'), :admins_professors_path
  add_breadcrumb I18n.t('breadcrumbs.professors.new'), :new_admins_professor_path,
                 only: [:new, :create]

  def index
    @professors = Professor.order(name: :asc).page params[:page]
  end

  def new
    @professor = Professor.new
  end

  def create
    @professor = Professor.new(professor_params)
    if @professor.save
      success_create_message
      redirect_to admins_professors_path
    else
      error_message
      render :new
    end
  end

  def edit
    add_breadcrumb I18n.t('breadcrumbs.professors.edit', name: "##{@professor.id}"),
                   :edit_admins_professor_path
  end

  def update
    if @professor.update(professor_params)
      success_update_message
      redirect_to admins_professor_path(@professor)
    else
      add_breadcrumb I18n.t('breadcrumbs.professors.edit', name: "##{@professor.id}"),
                     :edit_admins_professor_path

      error_message
      render :edit
    end
  end

  def destroy
    if @professor.destroy
      success_destroy_message
    else
      alert_destroy_bond_message
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
