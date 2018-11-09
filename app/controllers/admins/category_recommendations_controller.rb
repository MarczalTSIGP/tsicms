class Admins::CategoryRecommendationsController < Admins::BaseController
  before_action :set_category_recommendation, only: [:edit, :update, :destroy]

  add_breadcrumb I18n.t('breadcrumbs.category_recommendations.name'),
                 :admins_category_recommendations_path
  add_breadcrumb I18n.t('breadcrumbs.category_recommendations.new'),
                 :new_admins_category_recommendation_path, only: [:new, :create]

  def index
    @categories = CategoryRecommendation.order(name: :asc)
  end

  def new
    @category = CategoryRecommendation.new
  end

  def create
    @category = CategoryRecommendation.new(category_recommendation_params)

    if @category.save
      flash[:success] = I18n.t('flash.actions.create.f',
                               resource_name: CategoryRecommendation.model_name.human)
      redirect_to admins_category_recommendations_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :new
    end
  end

  def edit
    add_breadcrumb I18n.t('breadcrumbs.category_recommendations.edit', name: "##{@category.id}"),
                   :edit_admins_category_recommendation_path
  end

  def update
    if @category.update(category_recommendation_params)
      flash[:success] = I18n.t('flash.actions.update.f',
                               resource_name: CategoryRecommendation.model_name.human)
      redirect_to admins_category_recommendations_path
    else
      add_breadcrumb I18n.t('breadcrumbs.category_recommendations.edit', name: "##{@category.id}"),
                     :edit_admins_category_recommendation_path

      flash.now[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:success] = I18n.t('flash.actions.destroy.f',
                             resource_name: CategoryRecommendation.model_name.human)
    redirect_to admins_category_recommendations_path
  end

  protected

  def category_recommendation_params
    params.require(:category_recommendation).permit(:name)
  end

  def set_category_recommendation
    @category = CategoryRecommendation.find(params[:id])
  end
end
