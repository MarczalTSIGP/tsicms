class Admins::DisciplinesController < Admins::BaseController

  add_breadcrumb "Disciplinas", :admins_disciplines_path
  
  before_action :set_discipline, only: [:edit, :update, :destroy, :show]
  
  def index
    @disciplines = Discipline.includes(period: [:matrix]).
      order('matrices.name ASC', 'periods.name ASC')
  end

  def new
    add_breadcrumb "Nova Disciplina", :new_admins_discipline_path
    @discipline = Discipline.new
  end

  def edit
    add_breadcrumb "Editar Disciplina: #{@discipline.name} ", :edit_admins_discipline_path
  end

  def show
    add_breadcrumb "Visualizando Disciplina: #{@discipline.name} ", :admins_academic_path
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
