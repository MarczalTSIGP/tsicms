class Admins::DisciplinesController < Admins::BaseController
  before_action :set_discipline, only: [:edit, :update, :destroy, :show]

  add_breadcrumb I18n.t('breadcrumbs.disciplines.name'), :admins_disciplines_path
  add_breadcrumb I18n.t('breadcrumbs.disciplines.new'), :new_admins_discipline_path, only: [:new, :create]
  
  def index
    @disciplines = Discipline.includes(period: [:matrix]).
      order('matrices.name ASC', 'periods.name ASC')
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
      flash[:success] = I18n.t('flash.actions.create.f',
                               resource_name: Discipline.model_name.human)
      redirect_to admins_disciplines_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :new
    end
  end

  def update
    if @discipline.update(discipline_params)
      redirect_to admins_disciplines_path
      flash[:success] = I18n.t('flash.actions.update.f',
                               resource_name: Discipline.model_name.human)
    else
      add_breadcrumb I18n.t('breadcrumbs.disciplines.edit', name: "##{@discipline.id}"),
                        :edit_admins_discipline_path

      flash.now[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  def destroy
    @discipline.destroy
    flash[:success] = I18n.t('flash.actions.destroy.f',
                             resource_name: Discipline.model_name.human)
    redirect_to admins_disciplines_path
  end

  private
  def discipline_params
    params.require(:discipline).permit(:name, :code, :hours, :menu, :period_id)
  end

  def set_discipline
    @discipline = Discipline.find(params[:id])
  end
end
