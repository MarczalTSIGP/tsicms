class Admins::StaticPagesController < Admins::BaseController

  add_breadcrumb "Páginas Estáticas", :admins_static_pages_path

  before_action :set_static_page, only: [:edit, :update, :destroy]

  def index
    @static_pages = StaticPage.order(created_at: :desc)
  end

  def new
    add_breadcrumb "Nova Página Estática", :new_admins_static_page_path
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
    add_breadcrumb "Editar Página Estática", :edit_admins_static_page_path
  end

  def update
    if @static_page.update_attributes(static_page_params)
      flash[:success] = I18n.t('flash.actions.update.f',
                               resource_name: StaticPage.model_name.human)
      redirect_to admins_static_pages_path
    else
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
