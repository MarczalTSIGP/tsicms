class Admins::StaticPagesController < Admins::BaseController
  before_action :set_static_page, only: [:edit, :update, :destroy]

  add_breadcrumb I18n.t('breadcrumbs.static_pages.name'), :admins_static_pages_path
  add_breadcrumb I18n.t('breadcrumbs.static_pages.new'), :new_admins_static_page_path,
                 only: [:new, :create]

  def index
    @static_pages = StaticPage.order(created_at: :desc).page params[:page]
  end

  def new
    @static_page = StaticPage.new
  end

  def create
    @static_page = StaticPage.new(static_page_params)

    if @static_page.save
      feminine_success_create_message
      redirect_to admins_static_pages_path
    else
      error_message
      render :new
    end
  end

  def edit
    add_breadcrumb I18n.t('breadcrumbs.static_pages.edit', name: "##{@static_page.id}"),
                   :edit_admins_static_page_path
  end

  def update
    if @static_page.update(static_page_params)
      feminine_success_update_message
      redirect_to admins_static_pages_path
    else
      add_breadcrumb I18n.t('breadcrumbs.static_pages.edit', name: "##{@static_page.id}"),
                     :edit_admins_static_page_path

      error_message
      render :edit
    end
  end

  def destroy
    @static_page.destroy
    feminine_success_destroy_message
    redirect_to admins_static_pages_path
  end

  def trainee
    find_static_page I18n.t('helpers.trainee')
    find_professor_responsible( I18n.t('helpers.trainee'))
  end

  def tcc
    find_static_page  I18n.t('helpers.tcc')
    find_professor_responsible( I18n.t('helpers.tcc'))
  end

  def monitor
    find_static_page I18n.t('helpers.monitor')
    find_professor_responsible( I18n.t('helpers.monitor'))
  end

  def instruction_subscription
    find_static_page I18n.t('helpers.instruction_subscription')
    find_professor_responsible I18n.t('helpers.instruction_subscription')
  end
  def be_our_student
    find_static_page I18n.t('helpers.be_our_student')
    find_professor_responsible I18n.t('helpers.be_our_student')
  end
  def extension_activity
    find_static_page I18n.t('helpers.extension_activity')
    find_professor_responsible I18n.t('helpers.extension_activity')
  end
  def course_about
    find_static_page I18n.t('helpers.course_about')
    find_professor_responsible I18n.t('helpers.course_about')
  end
  def history
    @static_page = StaticPage.find(params[:static_page_id])
    @activity_professors = Activity.activity_professors(@static_page.title).page params[:page]

    add_breadcrumb I18n.t('breadcrumbs.static_pages.historic', name: "##{@static_page.id}"),
                   :admins_static_page_history_path
  end

  protected

  def static_page_params
    params.require(:static_page).permit(:title, :sub_title, :content, :permalink)
  end

  def set_static_page
    @static_page = StaticPage.find(params[:id])
  end

  private

  def find_professor_responsible(title)
    @professor = Activity.current_responsible(title)
  end

  def find_static_page(title)
    @static_page = StaticPage.find_by!(title: title)
  end
end
