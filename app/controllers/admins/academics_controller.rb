class Admins::AcademicsController < Admins::BaseController
  before_action :set_academic, only: [:edit, :update, :destroy]

  add_breadcrumb I18n.t('breadcrumbs.academics.name'), :admins_academics_path
  add_breadcrumb I18n.t('breadcrumbs.academics.new'), :new_admins_academic_path,
                 only: [:new, :create]

  def index
    @academics = Academic.order(created_at: :desc)
  end

  def new
    @academic = Academic.new
  end

  def create
    @academic = Academic.new(academic_params)
    if @academic.save
      success_create_message
      redirect_to admins_academics_path
    else
      error_message
      render :new
    end
  end

  def edit
    add_breadcrumb I18n.t('breadcrumbs.academics.edit', name: "##{@academic.id}"),
                   :edit_admins_academic_path
  end

  def update
    if @academic.update(academic_params)
      success_update_message
      redirect_to admins_academics_path
    else
      add_breadcrumb I18n.t('breadcrumbs.academics.edit', name: "##{@academic.id}"),
                     :edit_admins_academic_path

      error_message
      render :edit
    end
  end

  def destroy
    @academic.destroy
    success_destroy_message
    redirect_to admins_academics_path
  end

  def show
    add_breadcrumb I18n.t('breadcrumbs.academics.show', name: "##{@academic.id}"),
                   :admins_academic_path
  end

  protected

  def academic_params
    params.require(:academic).permit(:name,
                                     :image,
                                     :contact,
                                     :image_cache,
                                     :graduated)
  end

  def set_academic
    @academic = Academic.find(params[:id])
  end
end
