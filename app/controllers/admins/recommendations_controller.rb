class Admins::RecommendationsController < Admins::BaseController

  add_breadcrumb "Recomendações de Conteúdo", :admins_recommendations_path

  before_action :set_recommendation, only: [:edit, :update, :destroy]
  before_action :load_categories, only: [:new, :create, :edit, :update]

  def index
    @recommendations = Recommendation.order(created_at: :desc)
  end

  def new
    add_breadcrumb "Nova Recomendação", :new_admins_recommendation_path
    @recommendation = Recommendation.new
  end

  def create
    @recommendation = Recommendation.new(recommendation_params)

    if @recommendation.save
      flash[:success] = I18n.t('flash.actions.create.f',
                               resource_name: Recommendation.model_name.human)
      redirect_to admins_recommendations_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :new
    end
  end

  def edit
    add_breadcrumb "Editar Recomendação: #{@recommendation.title}", :edit_admins_recommendation_path
  end

  def update
    if @recommendation.update_attributes(recommendation_params)
      flash[:success] = I18n.t('flash.actions.update.f',
                               resource_name: Recommendation.model_name.human)
      redirect_to admins_recommendations_path
    else
      flash.now[:error] = I18n.t('flash.actions.errors')
      render :edit
    end
  end

  def destroy
    @recommendation.destroy
    flash[:success] = I18n.t('flash.actions.destroy.f',
                             resource_name: Recommendation.model_name.human)
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
