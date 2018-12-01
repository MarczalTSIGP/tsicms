class Admins::DisciplineMonitorsController < Admins::BaseController
  before_action :set_monitor, only: [:show, :edit, :update, :destroy]

  before_action :load_academics, only: [:new, :create, :edit, :update]
  before_action :load_monitor_types, only: [:new, :create, :edit, :update]
  before_action :load_professors, only: [:new, :create, :edit, :update]
  before_action :load_disciplines, only: [:new, :create, :edit, :update]
  before_action :load_date, only: [:new, :create, :edit, :update]

  add_breadcrumb I18n.t('breadcrumbs.discipline_monitors.name'),
                 :admins_discipline_monitors_path
  add_breadcrumb I18n.t('breadcrumbs.discipline_monitors.new'),
                 :new_admins_discipline_monitor_path, only: [:new, :create]

  def index
    @discipline_monitors = DisciplineMonitor.order(year: :desc, semester: :desc)
  end

  def new
    @discipline_monitor = DisciplineMonitor.new
  end

  def show
    add_breadcrumb I18n.t('breadcrumbs.discipline_monitors.show',
                          name: "##{@discipline_monitor.id}"),
                   :admins_discipline_monitor_path
  end

  def create
    @discipline_monitor = DisciplineMonitor.new(monitor_params)
    if @discipline_monitor.save
      feminine_success_create_message
      redirect_to admins_discipline_monitors_path
    else
      error_message
      render :new
    end
  end

  def edit
    add_breadcrumb I18n.t('breadcrumbs.discipline_monitors.edit',
                          name: "##{@discipline_monitor.id}"),
                   :edit_admins_discipline_monitor_path
  end

  def update
    if @discipline_monitor.update(monitor_params)
      feminine_success_update_message
      redirect_to admins_discipline_monitors_path
    else
      add_breadcrumb I18n.t('breadcrumbs.discipline_monitors.edit',
                            name: "##{@discipline_monitor.id}"),
                     :edit_admins_discipline_monitor_path

      error_message
      render :edit
    end
  end

  def destroy
    @discipline_monitor.destroy
    feminine_success_destroy_message
    redirect_to admins_discipline_monitors_path
  end

  protected

  def monitor_params
    mp = [:year, :semester,
          :description, :monitor_type_id,
          :academic_id,
          professor_ids: [],
          discipline_ids: []]

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
    @years = (2011..Time.zone.today.year).to_a.reverse
  end
end
