class Admins::PostsController < Admins::BaseController
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :load_categories, only: [:new, :create, :edit, :update]

  add_breadcrumb I18n.t('breadcrumbs.posts.name'), :admins_posts_path
  add_breadcrumb I18n.t('breadcrumbs.posts.new'), :new_admins_post_path,
                 only: [:new, :create]

  def index
    @posts = Post.order(created_at: :desc).page params[:page]
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      feminine_success_create_message
      redirect_to admins_posts_path
    else
      error_message
      render :new
    end
  end

  def edit
    add_breadcrumb I18n.t('breadcrumbs.posts.edit', name: "##{@post.id}"),
                   :edit_admins_post_path
  end

  def update
    if @post.update(post_params)
      feminine_success_update_message
      redirect_to admins_posts_path
    else
      add_breadcrumb I18n.t('breadcrumbs.posts.edit', name: "##{@post.id}"),
                     :edit_admins_post_path

      error_message
      render :edit
    end
  end

  def destroy
    if @post.destroy
      feminine_success_destroy_message
    else
      alert_destroy_bond_message
    end
    redirect_to admins_posts_path
  end

  protected

  def post_params
    params.require(:post).permit(:title,
                                 :description,
                                 :posted,
                                 :post_category_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def load_categories
    @post_categories = PostCategory.all.order(name: :asc)
  end
end
