class Admins::MatricesController < Admins::BaseController
  before_action :set_matrix, only: [:edit, :update, :destroy, :show]

  add_breadcrumb I18n.t('breadcrumbs.matrices.name'), :admins_matrices_path
  add_breadcrumb I18n.t('breadcrumbs.matrices.new'), :new_admins_matrix_path, only: [:new, :create]

  def index
    @matrices = Matrix.order(:name)
  end

  def new
    @matrix = Matrix.new
  end

  def edit
    add_breadcrumb I18n.t('breadcrumbs.matrices.edit', name: "##{@matrix.id}"),
                   :edit_admins_matrix_path
  end

  def create
    @matrix = Matrix.new(matrix_params)
    if @matrix.save
      flash[:success] = I18n.t('flash.actions.create.f',
                               resource_name: Matrix.model_name.human)
      redirect_to admins_matrices_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :new
    end
  end

  def update
    if @matrix.update(matrix_params)
      flash[:success] = I18n.t('flash.actions.update.f',
                               resource_name: Matrix.model_name.human)
      redirect_to admins_matrices_path
    else
      add_breadcrumb I18n.t('breadcrumbs.matrices.edit', name: "##{@matrix.id}"),
                     :edit_admins_matrix_path

      flash.now[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  def destroy
    @matrix.destroy
    flash[:success] = I18n.t('flash.actions.destroy.f',
                             resource_name: Matrix.model_name.human)
    redirect_to admins_matrices_path
  end

  def show
    add_breadcrumb I18n.t('breadcrumbs.matrices.show', name: "##{@matrix.id}"),
                   :admins_matrix_path
  end

  private

  def matrix_params
    params.require(:matrix).permit(:name)
  end

  def set_matrix
    @matrix = Matrix.find(params[:id])
  end
end
