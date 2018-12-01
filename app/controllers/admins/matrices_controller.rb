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
      feminine_success_create_message
      redirect_to admins_matrices_path
    else
      error_message
      render :new
    end
  end

  def update
    if @matrix.update(matrix_params)
      feminine_success_update_message
      redirect_to admins_matrices_path
    else
      add_breadcrumb I18n.t('breadcrumbs.matrices.edit', name: "##{@matrix.id}"),
                     :edit_admins_matrix_path

      error_message
      render :edit
    end
  end

  def destroy
    @matrix.destroy
    feminine_success_destroy_message
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
