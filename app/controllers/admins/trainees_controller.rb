class Admins::TraineesController < Admins::BaseController
  before_action :set_trainee, only: [:edit, :update, :destroy, :show]

  add_breadcrumb I18n.t('breadcrumbs.trainees.name'), :admins_trainees_path
  add_breadcrumb I18n.t('breadcrumbs.trainees.new'), :new_admins_trainee_path, only: [:new, :create]

  def index
    @trainees = Trainee.order(created_at: :desc).page params[:page]
  end

  def new
    @trainee = Trainee.new
    add_company(params[:company])
  end

  def show
    add_breadcrumb I18n.t('breadcrumbs.trainees.show', name: "##{@trainee.id}"),
                   :admins_trainee_path
  end

  def create
    @trainee = Trainee.new(trainee_params)
    if @trainee.save
      feminine_success_create_message
      redirect_to admins_trainees_path
    else
      error_message
      render :new
    end
  end

  def edit
    add_breadcrumb I18n.t('breadcrumbs.trainees.edit', name: "##{@trainee.id}"),
                   :edit_admins_trainee_path
  end

  def update
    if @trainee.update(trainee_params)
      feminine_success_update_message
      redirect_to admins_trainee_path(@trainee)
    else
      add_breadcrumb I18n.t('breadcrumbs.trainees.edit', name: "##{@trainee.id}"),
                     :edit_admins_trainee_path
      error_message
      render :edit
    end
  end

  def destroy
    feminine_success_destroy_message if @trainee.destroy
    redirect_to admins_trainees_path
  end

  protected

  def add_company(company_id)
    return unless company_id

    @company = Company.find(company_id)
    @trainee.company = @company if @company
  end

  def trainee_params
    params.require(:trainee).permit(:title,
                                    :description,
                                    :company_id,
                                    :trainee_status_id)
  end

  def set_trainee
    @trainee = Trainee.find(params[:id])
  end
end
