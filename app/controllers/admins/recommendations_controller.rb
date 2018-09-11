class Admins::RecommendationsController < Admins::BaseController
  before_action :set_recommendation, only: [:edit, :update, :destroy]

  def index
    @recommendations = Recommendation.order(created_at: :asc)
  end

  def new
    @recommendation = Recommendation.new
  end

  def create
    @recommendation = Recommendation.new(recommendation_params)

    if @recommendation.save
      flash[:success] = 'Recomendação criada com sucesso!'
      redirect_to admins_recommendations_path
    else
      flash[:error] = 'Existem dados incorretos!'
      render :new
    end
  end

  def edit; end

  def update
    if @recommendation.update_attributes(recommendation_params)
      flash[:success] = 'Recomendação atualizada com sucesso!'
      redirect_to admins_recommendations_path
    else
      flash[:error] = 'Existem dados incorretos!'
      render :edit
    end
  end

  def destroy
    @recommendation.destroy
    flash[:success] = 'Recomendação removida com sucesso!'
    redirect_to admins_recommendations_path
  end

  protected

  def recommendation_params
    params.require(:recommendation).permit(:title, :description, :image, :category_recommendation_id)
  end

  def set_recommendation
    @recommendation = Recommendation.find(params[:id])
  end
end
