class Admins::CategoryRecommendationsController < Admins::BaseController

  add_breadcrumb "Categoria de Recomendações", :admins_category_recommendations_path

  before_action :set_category_recommendation, only: [:edit, :update, :destroy]

  def index
    @categories = CategoryRecommendation.order(name: :asc)
  end

  def new
    add_breadcrumb "Nova Categoria", :new_admins_category_recommendation_path
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
    add_breadcrumb "Editar Categoria", :edit_admins_category_recommendation_path
  end

  def update
    if @category.update_attributes(category_recommendation_params)
      flash[:success] = I18n.t('flash.actions.update.f',
                               resource_name: CategoryRecommendation.model_name.human)
      redirect_to admins_category_recommendations_path
    else
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
