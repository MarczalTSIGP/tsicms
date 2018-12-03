class Admins::DisciplinesController < Admins::BaseController
  before_action :set_discipline, only: [:edit, :update, :destroy, :show]

  add_breadcrumb I18n.t('breadcrumbs.disciplines.name'), :admins_disciplines_path
  add_breadcrumb I18n.t('breadcrumbs.disciplines.new'), :new_admins_discipline_path,
                 only: [:new, :create]

  def index
    @disciplines = Discipline.includes(period: [:matrix])
                             .order('matrices.name ASC', 'periods.name ASC')
                             .page(params[:page])
  end

  def new
    @discipline = Discipline.new
  end

  def edit
    add_breadcrumb I18n.t('breadcrumbs.disciplines.edit', name: "##{@discipline.id}"),
                   :edit_admins_discipline_path
  end

  def show
    add_breadcrumb I18n.t('breadcrumbs.disciplines.show', name: "##{@discipline.id}"),
                   :admins_discipline_path
  end

  def create
    @discipline = Discipline.new(discipline_params)
    if @discipline.save
      feminine_success_create_message
      redirect_to admins_disciplines_path
    else
      error_message
      render :new
    end
  end

  def update
    if @discipline.update(discipline_params)
      redirect_to admins_disciplines_path
      feminine_success_update_message
    else
      add_breadcrumb I18n.t('breadcrumbs.disciplines.edit', name: "##{@discipline.id}"),
                     :edit_admins_discipline_path

      error_message
      render :edit
    end
  end

  def destroy
    @discipline.destroy
    feminine_success_destroy_message
    redirect_to admins_disciplines_path
  end

  private

  def discipline_params
    params.require(:discipline).permit(:name, :code, :initials,
                                       :theoretical_classes, :practical_classes, :distance_classes,
                                       :hours, :menu, :period_id)
  end

  def set_discipline
    @discipline = Discipline.find(params[:id])
  end
end
