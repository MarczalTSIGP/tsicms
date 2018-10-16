class Admins::DisciplineMonitorsController < Admins::BaseController
  before_action :set_monitor, only: [:edit, :update, :destroy]
  before_action :load_academics, only: [:new, :create, :edit, :update]
  before_action :load_monitor_types, only: [:new, :create, :edit, :update]
  before_action :load_professors, only: [:new, :create, :edit, :update]

  def index
    @discipline_monitors = DisciplineMonitor.order(created_at: :desc)
  end

  def new
    @discipline_monitor = DisciplineMonitor.new
  end

  def show
    set_monitor
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
    set_monitor
  end

  def update
    if @discipline_monitor.update_attributes(monitor_params)
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
    params.require(:discipline_monitor).permit(:year,
                                                :semester,
                                                :description,
                                                :monitor_type_id,
                                                :academic_id,
                                                :discipline_monitor_professors_attributes => [:id,
                                                                                              :discipline_monitor_id,
                                                                                              :professor_id,
                                                                                              :_destroy,
                                                                                              :professor_attributes => [:id,
                                                                                                                        :name]])
  end

  def set_monitor
    @discipline_monitor = DisciplineMonitor.find(params[:id])
  end

  def load_academics
    @academics = Academic.all.order(name: :asc)
  end

  def load_monitor_types
      @monitor_types = MonitorType.all.order(name: :asc)
  end

  def load_professors
    @professors = Professor.all.order(name: :asc)
  end
end
