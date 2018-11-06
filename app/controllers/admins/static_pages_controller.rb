class Admins::StaticPagesController < Admins::BaseController
  before_action :set_static_page, only: [:edit, :update, :destroy]

  add_breadcrumb I18n.t('breadcrumbs.static_pages.name'), :admins_static_pages_path
  add_breadcrumb I18n.t('breadcrumbs.static_pages.new'), :new_admins_static_page_path, only: [:new, :create]

  def index
    @static_pages = StaticPage.order(created_at: :desc)
  end

  def new
    @static_page = StaticPage.new
  end

  def create
    @static_page = StaticPage.new(static_page_params)

    if @static_page.save
      flash[:success] = I18n.t('flash.actions.create.f',
                               resource_name: StaticPage.model_name.human)
      redirect_to admins_static_pages_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :new
    end
  end

  def edit
    add_breadcrumb I18n.t('breadcrumbs.static_pages.edit', name: "##{@static_page.id}"),
                   :edit_admins_static_page_path
  end

  def update
    if @static_page.update_attributes(static_page_params)
      flash[:success] = I18n.t('flash.actions.update.f',
                               resource_name: StaticPage.model_name.human)
      redirect_to admins_static_pages_path
    else
      add_breadcrumb I18n.t('breadcrumbs.static_pages.edit', name: "##{@static_page.id}"),
                   :edit_admins_static_page_path

      flash.now[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  def destroy
    @static_page.destroy
    flash[:success] = I18n.t('flash.actions.destroy.f',
                             resource_name: StaticPage.model_name.human)
    redirect_to admins_static_pages_path
  end

  protected

  def static_page_params
    params.require(:static_page).permit(:title, :sub_title, :content, :permalink)
  end

  def set_static_page
    @static_page = StaticPage.find(params[:id])
  end
end
