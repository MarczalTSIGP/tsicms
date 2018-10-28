class Admins::TraineesController < Admins::BaseController
  before_action :set_trainee, only: [:edit, :update, :destroy, :show]

  def index
    @trainees = Trainee.order(created_at: :desc)
  end

  def new
    @trainee = Trainee.new
    add_company(params[:company])
  end

  def show;
  end

  def create
    @trainee = Trainee.new(trainee_params)
    if @trainee.save
      flash[:success] = I18n.t('flash.actions.create.m', resource_name: Trainee.model_name.human)
      redirect_to admins_trainees_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :new
    end
  end

  def edit;
  end

  def update
    if @trainee.update(trainee_params)
      flash[:success] = I18n.t('flash.actions.update.m', resource_name: Trainee.model_name.human)
      redirect_to admins_trainee_path(@trainee)
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  def destroy
    if @trainee.destroy
      flash[:success] = I18n.t('flash.actions.destroy.m',
                               resource_name: Trainee.model_name.human)
    end
    redirect_to admins_treinees_path
  end

  protected

  def add_company(company_id)
    if company_id
      @company = Company.find(company_id)
      @trainee.company = @company if @company
    end
  end

  def trainee_params
    params.require(:trainee).permit(:title, :description, :company, :treinee_statuses)
  end

  def set_trainee
    @trainee = Trainee.find(params[:id])
  end
end
