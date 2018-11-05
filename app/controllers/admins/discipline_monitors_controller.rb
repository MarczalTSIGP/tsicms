class Admins::DisciplineMonitorsController < Admins::BaseController
  before_action :set_monitor, only: [:show, :edit, :update, :destroy]

  before_action :load_academics, only: [:new, :create, :edit, :update]
  before_action :load_monitor_types, only: [:new, :create, :edit, :update]
  before_action :load_professors, only: [:new, :create, :edit, :update]
  before_action :load_disciplines, only: [:new, :create, :edit, :update]
  before_action :load_date, only: [:new, :create, :edit, :update]

  def index
    @discipline_monitors = DisciplineMonitor.order(year: :desc, semester: :desc)
  end

  def new
    @discipline_monitor = DisciplineMonitor.new
  end

  def show
  end

  def create
    @discipline_monitor = DisciplineMonitor.new(monitor_params)
    if @discipline_monitor.save
      flash[:success] = I18n.t('flash.actions.create.f',
                               resource_name: DisciplineMonitor.model_name.human)
      redirect_to admins_discipline_monitors_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :new
    end
  end

  def edit
  end

  def update
    if @discipline_monitor.update(monitor_params)
      flash[:success] = I18n.t('flash.actions.update.f',
                               resource_name: DisciplineMonitor.model_name.human)
      redirect_to admins_discipline_monitors_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  def destroy
    @discipline_monitor.destroy
    flash[:success] = I18n.t('flash.actions.destroy.f',
                             resource_name: DisciplineMonitor.model_name.human)
    redirect_to admins_discipline_monitors_path
  end

  protected

  def monitor_params
    mp = [:year,
      :semester,
      :description,
      :monitor_type_id,
      :academic_id,
      professor_ids:[],
      discipline_ids:[]
    ]

    unless params[:discipline_monitor][:semester].empty?
      params[:discipline_monitor][:semester] = params[:discipline_monitor][:semester].to_i
    end
    params.require(:discipline_monitor).permit(mp)
  end

  def set_monitor
    @discipline_monitor = DisciplineMonitor.find(params[:id])
  end

  def load_academics
    @academics = Academic.order(:name)
  end

  def load_monitor_types
    @monitor_types = MonitorType.order(:name)
  end

  def load_professors
    @professors = Professor.order(:name)
  end

  def load_disciplines
    @disciplines = Discipline.order(:name)
  end

  def load_date
    @years = (2011..Date.today.year).to_a.reverse
  end
end
