class Admins::PostCategoriesController < Admins::BaseController
  before_action :set_post_category, only: [:edit, :update, :destroy]

  add_breadcrumb I18n.t('breadcrumbs.post_categories.name'),
                 :admins_post_categories_path
  add_breadcrumb I18n.t('breadcrumbs.post_categories.new'),
                 :new_admins_post_category_path, only: [:new, :create]

  def index
    @post_categories = PostCategory.order(name: :asc).page params[:page]
  end

  def new
    @post_category = PostCategory.new
  end

  def create
    @post_category = PostCategory.new(post_category_params)

    if @post_category.save
      feminine_success_create_message
      redirect_to admins_post_categories_path
    else
      error_message
      render :new
    end
  end

  def edit
    add_breadcrumb I18n.t('breadcrumbs.post_categories.edit', name: "##{@post_category.id}"),
                   :edit_admins_post_category_path
  end

  def update
    if @post_category.update(post_category_params)
      feminine_success_update_message
      redirect_to admins_post_categories_path
    else
      add_breadcrumb I18n.t('breadcrumbs.post_categories.edit', name: "##{@post_category.id}"),
                     :edit_admins_post_category_path

      error_message
      render :edit
    end
  end

  def destroy
    @post_category.destroy

    feminine_success_destroy_message
    redirect_to admins_post_categories_path
  end

  protected

  def post_category_params
    params.require(:post_category).permit(:name)
  end

  def set_post_category
    @post_category = PostCategory.find(params[:id])
  end
end
