class RecommendationsController < ApplicationController
  add_breadcrumb I18n.t('breadcrumbs.recommendations.name'), :recommendations_path

  def index
    @recommendations = Recommendation.order(created_at: :desc).page params[:page]
    @categories = CategoryRecommendation.order(name: :asc)
    @recommendations_category = Recommendation.order(created_at: :desc)
                                              .where(category_recommendation_id: params[:id])
  end

  def show
    @recommendation = Recommendation.find(params[:id])
    add_breadcrumb I18n.t('breadcrumbs.recommendations.show', name: "##{@recommendation.id}"),
                   :recommendation_path
  end

  def recommendations_by_category
    @recommendations_category = CategoryRecommendation.find(params[:id])
  end
end
