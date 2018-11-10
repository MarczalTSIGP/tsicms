class Admins::RecommendationsController < Admins::BaseController
  before_action :set_recommendation, only: [:edit, :update, :destroy]
  before_action :load_categories, only: [:new, :create, :edit, :update]

  add_breadcrumb I18n.t('breadcrumbs.recommendations.name'), :admins_recommendations_path
  add_breadcrumb I18n.t('breadcrumbs.recommendations.new'), :new_admins_recommendation_path,
                 only: [:new, :create]

  def index
    @recommendations = Recommendation.order(created_at: :desc)
  end

  def new
    @recommendation = Recommendation.new
  end

  def create
    @recommendation = Recommendation.new(recommendation_params)

    if @recommendation.save
      feminine_success_create_message
      redirect_to admins_recommendations_path
    else
      error_message
      render :new
    end
  end

  def edit
    add_breadcrumb I18n.t('breadcrumbs.recommendations.edit', name: "##{@recommendation.id}"),
                   :edit_admins_recommendation_path
  end

  def update
    if @recommendation.update(recommendation_params)
      feminine_success_update_message
      redirect_to admins_recommendations_path
    else
      add_breadcrumb I18n.t('breadcrumbs.recommendations.edit', name: "##{@recommendation.id}"),
                     :edit_admins_recommendation_path

      error_message
      render :edit
    end
  end

  def destroy
    @recommendation.destroy
    feminine_success_destroy_message
    redirect_to admins_recommendations_path
  end

  protected

  def recommendation_params
    params.require(:recommendation).permit(:title,
                                           :description,
                                           :image,
                                           :image_cache,
                                           :category_recommendation_id)
  end

  def set_recommendation
    @recommendation = Recommendation.find(params[:id])
  end

  def load_categories
    @categories = CategoryRecommendation.all.order(name: :asc)
  end
end
